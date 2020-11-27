import 'dart:math';
import '../utility/sudokuarray.dart';
import '../utility/difficulty.dart';
import 'package:flutter_charts/flutter_charts.dart';

class SudokuService {
  List<List<dynamic>> resolution;
  List<List<dynamic>> initialValues;
  List<List<dynamic>> acutalValues;
  Difficulty difficulty;
  int difficultyInt = 0;
  int counter;

  SudokuService() {}

  void resetGame() {
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

  void setDifficulty(Difficulty difficulty) {
    this.difficulty = difficulty;
    switch (this.difficulty) {
      case Difficulty.Easy:
        this.difficultyInt = 5;
        break;
      case Difficulty.Normal:
        this.difficultyInt = 10;
        break;
      case Difficulty.Hard:
        this.difficultyInt = 15;
        break;
    }
  }

  void generateNewGame({Difficulty difficulty = Difficulty.Easy}) {
    setDifficulty(difficulty);
    // https://www.101computing.net/sudoku-generator-algorithm/
    // https://www.101computing.net/backtracking-algorithm-sudoku-solver/
    // initialise empty 9 by 9 grid
    var grid = [
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
    ];

    fillGrid(grid);
    this.resolution = SudokuArray.duplicateGrid(grid);
    removeNumbersFromSudoku(grid);
    this.initialValues = grid;
    acutalValues = SudokuArray.duplicateGrid(initialValues);
  }

  // A backtracking/recursive function to check all possible combinations of numbers until a solution is found
  bool solveGrid(List<List<dynamic>> grid) {
    // global counter
    //int counter = 0; // evtl muss der sogar global für die ganze Klasse sein?!
    // Find next empty cell
    int row;
    int col;

    for (int i = 0; i < 81; i++) {
      row = (i ~/ 9);
      col = i % 9;
      if (grid[row][col] == 0) {
        for (int value = 1; value < 10; value++) {
          // Check that this value has not already be used on this row
          if (!grid[row].contains(value)) {
            // Check that this value has not already be used on this column
            if (!transpose(grid)[col].contains(value)) {
              // Identify which of the 9 squares we are working on
              List<dynamic> square = [];
              if (row < 3) {
                if (col < 3)
                  square = SudokuArray.getSquareValues(grid, 0, 0);
                else if (col < 6)
                  square = SudokuArray.getSquareValues(grid, 0, 3);
                else
                  square = SudokuArray.getSquareValues(grid, 0, 6);
              } else if (row < 6) {
                if (col < 3)
                  square = SudokuArray.getSquareValues(grid, 3, 0);
                else if (col < 6)
                  square = SudokuArray.getSquareValues(grid, 3, 3);
                else
                  square = SudokuArray.getSquareValues(grid, 3, 6);
              } else {
                if (col < 3)
                  square = SudokuArray.getSquareValues(grid, 6, 0);
                else if (col < 6)
                  square = SudokuArray.getSquareValues(grid, 6, 3);
                else
                  square = SudokuArray.getSquareValues(grid, 6, 6);
              }

              // Check that this value has not already be used on this 3x3 square
              if (!square.contains(value)) {
                grid[row][col] = value;
                if (SudokuArray.checkGrid(grid)) {
                  this.counter++;
                  break;
                } else {
                  if (solveGrid(grid)) {
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
    grid[row][col] = 0;

    return false;
  }

  List shuffle(List items) {
    var random = new Random();

    // Go through all elements.
    for (var i = items.length - 1; i > 0; i--) {
      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }

  // A backtracking/recursive function to check all possible combinations of numbers until a solution is found
  bool fillGrid(List<List<dynamic>> grid) {
    int row;
    int col;
    List<dynamic> numberList = [1, 2, 3, 4, 5, 6, 7, 8, 9];

    // Find next empty cell
    for (int i = 0; i < 81; i++) {
      row = (i ~/ 9);
      col = i % 9;
      if (grid[row][col] == 0) {
        shuffle(numberList);
        for (var value in numberList) {
          // Check that this value has not already be used on this row
          if (!grid[row].contains(value)) {
            // Check that this value has not already be used on this column
            if (!transpose(grid)[col].contains(value)) {
              // Identify which of the 9 squares we are working on
              List<dynamic> square = [];
              if (row < 3) {
                if (col < 3)
                  square = SudokuArray.getSquareValues(grid, 0, 0);
                else if (col < 6)
                  square = SudokuArray.getSquareValues(grid, 0, 3);
                else
                  square = SudokuArray.getSquareValues(grid, 0, 6);
              } else if (row < 6) {
                if (col < 3)
                  square = SudokuArray.getSquareValues(grid, 3, 0);
                else if (col < 6)
                  square = SudokuArray.getSquareValues(grid, 3, 3);
                else
                  square = SudokuArray.getSquareValues(grid, 3, 6);
              } else {
                if (col < 3)
                  square = SudokuArray.getSquareValues(grid, 6, 0);
                else if (col < 6)
                  square = SudokuArray.getSquareValues(grid, 6, 3);
                else
                  square = SudokuArray.getSquareValues(grid, 6, 6);
              }

              // Check that this value has not already be used on this 3x3 square
              if (!square.contains(value)) {
                grid[row][col] = value;
                if (SudokuArray.checkGrid(grid)) {
                  return true;
                } else {
                  if (fillGrid(grid)) {
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
    grid[row][col] = 0;

    return false;
  }

  void removeNumbersFromSudoku(List<List<dynamic>> grid) {
    // Start Removing Numbers one by one

    // A higher number of attempts will end up removing more numbers from the grid
    // Potentially resulting in more difficiult grids to solve!
    int attempts = this.difficultyInt;
    this.counter = 1;
    while (attempts > 0) {
      // Select a random cell that is not already empty
      var random = new Random();
      int row, col;
      do {
        row = random.nextInt(9);
        col = random.nextInt(9);
      } while (grid[row][col] == 0);

      // Remember its cell value in case we need to put it back
      var backup = grid[row][col];
      grid[row][col] = 0;

      // Take a full copy of the grid
      List<List<dynamic>> copyGrid = SudokuArray.duplicateGrid(grid);

      // Count the number of solutions that this grid has (using a backtracking approach implemented in the solveGrid() function)
      this.counter = 0;
      solveGrid(copyGrid);
      // If the number of solution is different from 1 then we need to cancel the change by putting the value we took away back in the grid
      if (this.counter != 1) {
        grid[row][col] = backup;
        // We could stop here, but we can also have another attempt with a different cell just to try to remove more numbers
        attempts -= 1;
      }
    }

    // Sudoku Ready
  }
}
