import 'dart:math';
import 'package:flutter_charts/flutter_charts.dart';
import '../utility/sudokuarray.dart';
import '../utility/difficulty.dart';

class SudokuService {
  List<List<int>> resolution;
  List<List<int>> initialValues;
  List<List<int>> acutalValues;
  bool helpOn = false;
  int _difficultyInt = 0;
  int _counter;

  void resetGame() {
    acutalValues = null;
    resolution = null;
    initialValues = null;
  }

  int getInitialValuesValue(int row, int column) {
    return SudokuArray.getValueFromSudokuArray(initialValues, row, column);
  }

  int getAcutalValuesValue(int row, int column) {
    return SudokuArray.getValueFromSudokuArray(acutalValues, row, column);
  }

  int getResolutionValue(int row, int column) {
    return SudokuArray.getValueFromSudokuArray(resolution, row, column);
  }

  // This algorithm is based on https://www.101computing.net/sudoku-generator-algorithm/
  void generateNewGame(Difficulty difficulty) {
    _setDifficulty(difficulty);
    var sudokuGrid = SudokuArray.getEmptySudokuGrid();

    // Generate a completely filled Sudoku
    _fillSudokuGrid(sudokuGrid);
    this.resolution = SudokuArray.duplicateSudokuGrid(sudokuGrid);
    _removeNumbersFromSudoku(sudokuGrid);
    this.initialValues = sudokuGrid;
    this.acutalValues = SudokuArray.duplicateSudokuGrid(initialValues);
  }

  void _setDifficulty(Difficulty difficulty) {
    var difficultyFactor = 5;
    switch (difficulty) {
      case Difficulty.Easy:
        _difficultyInt = 1 * difficultyFactor;
        break;
      case Difficulty.Normal:
        _difficultyInt = 2 * difficultyFactor;
        break;
      case Difficulty.Hard:
        _difficultyInt = 3 * difficultyFactor;
        break;
    }
  }

  // A backtracking/recursive function to check all possible combinations
  // of numbers until a solution is found
  bool _fillSudokuGrid(List<List<int>> sudokuGrid) {
    List<int> numberList = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    int row, col;

    // Find next empty cell
    for (int i = 0; i < 81; i++) {
      row = (i ~/ 9); // Division with truncating
      col = i % 9;
      if (sudokuGrid[row][col] == 0) {
        _shuffle(numberList);
        for (int value in numberList) {
          // Check that this value has not already be used on this row
          if (!sudokuGrid[row].contains(value)) {
            // Check that this value has not already be used on this column
            if (!transpose(sudokuGrid)[col].contains(value)) {
              // Identify which of the 9 squares we are working on
              List<int> square = SudokuArray.getSudokuSquareOfRowAndColumn(
                  sudokuGrid, row, col);

              // Check that this value has not already be used
              // on this 3x3 square
              if (!square.contains(value)) {
                sudokuGrid[row][col] = value;
                if (SudokuArray.checkSudokuGridFilled(sudokuGrid)) {
                  return true;
                } else {
                  if (_fillSudokuGrid(sudokuGrid)) {
                    return true;
                  }
                }
              }
            }
          }
        }
        break;
      }
    }
    sudokuGrid[row][col] = 0;

    return false;
  }

  List _shuffle(List items) {
    var random = new Random();

    for (var i = items.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }

  void _removeNumbersFromSudoku(List<List<int>> sudokuGrid) {
    // Start Removing Numbers one by one
    // A higher number of attempts will end up removing more numbers from the
    // SudokuGrid Potentially resulting in more difficiult SudokuGrids to solve!
    int attempts = _difficultyInt;
    _counter = 1;
    while (attempts > 0) {
      // Select a random cell that is not already empty
      var random = new Random();
      int row, col;
      do {
        row = random.nextInt(9);
        col = random.nextInt(9);
      } while (sudokuGrid[row][col] == 0);

      // Remember its cell value in case we need to put it back
      int backup = sudokuGrid[row][col];
      sudokuGrid[row][col] = 0;

      // Take a full copy of the sudokuGrid
      List<List<int>> copysudokuGrid =
          SudokuArray.duplicateSudokuGrid(sudokuGrid);

      // Count the number of solutions that this sudokuGrid has (using a
      // backtracking approach implemented in the _solvesudokuGrid() function)
      _counter = 0;
      _solvesudokuGrid(copysudokuGrid);
      // If the number of solution is different from 1 then we need to cancel the
      // change by putting the value we took away back in the SudokuGrid
      if (_counter != 1) {
        sudokuGrid[row][col] = backup;
        // We could stop here, but we can also have another attempt with a
        // different cell just to try to remove more numbers
        attempts -= 1;
      }
    }
  }

  // A backtracking/recursive function to check all possible combinations of
  // numbers until a solution is found
  bool _solvesudokuGrid(List<List<int>> sudokuGrid) {
    int row, col;

    for (int i = 0; i < 81; i++) {
      row = (i ~/ 9);
      col = i % 9;
      if (sudokuGrid[row][col] == 0) {
        for (int value = 1; value < 10; value++) {
          // Check that this value has not already be used on this row
          if (!sudokuGrid[row].contains(value)) {
            // Check that this value has not already be used on this column
            if (!transpose(sudokuGrid)[col].contains(value)) {
              // Identify which of the 9 squares we are working on
              List<int> square = SudokuArray.getSudokuSquareOfRowAndColumn(
                  sudokuGrid, row, col);

              // Check that this value has not already be used on this 3x3 square
              if (!square.contains(value)) {
                sudokuGrid[row][col] = value;
                if (SudokuArray.checkSudokuGridFilled(sudokuGrid)) {
                  _counter++;
                  break;
                } else {
                  if (_solvesudokuGrid(sudokuGrid)) {
                    return true;
                  }
                }
              }
            }
          }
        }
        break;
      }
    }
    sudokuGrid[row][col] = 0;

    return false;
  }
}
