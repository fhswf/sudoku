import 'dart:math';

class SudokuService {
  List<List<dynamic>> resolution;
  List<List<dynamic>> initialValues;
  int difficulty = 0;
  int counter;

  SudokuService(int difficulty) {
    this.difficulty = difficulty;
    // generateNewGame();
    implementierung();
  }

  void generateNewGame() {
    this.initialValues = [
      [1, 2, 3, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 4, 5, 6, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 7, 8, 9],
    ];
    this.resolution = [
      [1, 2, 3, 4, 5, 6, 7, 8, 9],
      [1, 2, 3, 4, 5, 6, 7, 8, 9],
      [1, 2, 3, 4, 5, 6, 7, 8, 9],
      [1, 2, 3, 4, 5, 6, 7, 8, 9],
      [1, 2, 3, 4, 5, 6, 7, 8, 9],
      [1, 2, 3, 4, 5, 6, 7, 8, 9],
      [1, 2, 3, 4, 5, 6, 7, 8, 9],
      [1, 2, 3, 4, 5, 6, 7, 8, 9],
      [1, 2, 3, 4, 5, 6, 7, 8, 9],
    ];
  }

  void implementierung() {
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
    this.resolution = duplicateGrid(grid);
    removeNumbersFromSudoku(grid);
    this.initialValues = grid;
  }

  // A function to check if the grid is full
  bool checkGrid(List<List<dynamic>> grid) {
    // return !grid.contains(0); // Prüfen ob das funktioniert
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid.length; j++) {
        if (grid[i][j] == 0) return false;
      }
    }

    // We have a complete grid!
    return true;
  }

  // Source: https://pub.dev/documentation/flutter_charts/latest/flutter_charts/transpose.html
  List<List<T>> transpose<T>(List<List<T>> colsInRows) {
    int nRows = colsInRows.length;
    if (colsInRows.length == 0) return colsInRows;

    int nCols = colsInRows[0].length;
    if (nCols == 0) throw new StateError("Degenerate matrix");

    // Init the transpose to make sure the size is right
    List<List<T>> rowsInCols = new List(nCols);
    for (int col = 0; col < nCols; col++) {
      rowsInCols[col] = new List(nRows);
    }

    // Transpose
    for (int row = 0; row < nRows; row++) {
      for (int col = 0; col < nCols; col++) {
        rowsInCols[col][row] = colsInRows[row][col];
      }
    }

    return rowsInCols;
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
                  square = getSquareValues(grid, 0, 0);
                else if (col < 6)
                  square = getSquareValues(grid, 0, 3);
                else
                  square = getSquareValues(grid, 0, 6);
              } else if (row < 6) {
                if (col < 3)
                  square = getSquareValues(grid, 3, 0);
                else if (col < 6)
                  square = getSquareValues(grid, 3, 3);
                else
                  square = getSquareValues(grid, 3, 6);
              } else {
                if (col < 3)
                  square = getSquareValues(grid, 6, 0);
                else if (col < 6)
                  square = getSquareValues(grid, 6, 3);
                else
                  square = getSquareValues(grid, 6, 6);
              }

              // Check that this value has not already be used on this 3x3 square
              if (!square.contains(value)) {
                grid[row][col] = value;
                if (checkGrid(grid)) {
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

  List<dynamic> getSquareValues(List<List<dynamic>> grid, int row, int column) {
    List<dynamic> square = [];

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        square.add(grid[i + row][j + column]);
      }
    }

    return square;
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
                  square = getSquareValues(grid, 0, 0);
                else if (col < 6)
                  square = getSquareValues(grid, 0, 3);
                else
                  square = getSquareValues(grid, 0, 6);
              } else if (row < 6) {
                if (col < 3)
                  square = getSquareValues(grid, 3, 0);
                else if (col < 6)
                  square = getSquareValues(grid, 3, 3);
                else
                  square = getSquareValues(grid, 3, 6);
              } else {
                if (col < 3)
                  square = getSquareValues(grid, 6, 0);
                else if (col < 6)
                  square = getSquareValues(grid, 6, 3);
                else
                  square = getSquareValues(grid, 6, 6);
              }

              // Check that this value has not already be used on this 3x3 square
              if (!square.contains(value)) {
                grid[row][col] = value;
                if (checkGrid(grid)) {
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

  List<List<dynamic>> duplicateGrid(List<List<dynamic>> grid) {
    List<List<dynamic>> copyGrid = [];
    for (var row in grid) {
      copyGrid.add([]);
      for (var col in row) {
        copyGrid.last.add(col);
      }
    }

    return copyGrid;
  }

  void removeNumbersFromSudoku(List<List<dynamic>> grid) {
    // Start Removing Numbers one by one

    // A higher number of attempts will end up removing more numbers from the grid
    // Potentially resulting in more difficiult grids to solve!
    int attempts = 5;
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
      List<List<dynamic>> copyGrid = duplicateGrid(grid);

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
