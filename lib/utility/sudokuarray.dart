class SudokuArray {
  static List<List<int>> getEmptySudokuGrid() {
    return [
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
  }

  static int getValueFromSudokuArray(
      List<List<int>> grid, int row, int column) {
    if (grid == null) return 0;
    return grid[row][column];
  }

  static List<List<int>> duplicateSudokuGrid(List<List<int>> grid) {
    List<List<int>> copyGrid = [];
    for (var row in grid) {
      copyGrid.add([]);
      for (var col in row) {
        copyGrid.last.add(col);
      }
    }

    return copyGrid;
  }

  // A function to check if the grid is full
  static bool checkSudokuGridFilled(List<List<int>> grid) {
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid.length; j++) {
        if (grid[i][j] == 0) return false;
      }
    }

    return true;
  }

  static List<String> getSudokuAsStringList(List<List<int>> sudoku) {
    List<String> stringlist = [];

    sudoku.forEach((element) {
      element.forEach((element) {
        stringlist.add(element.toString());
      });
    });

    return stringlist;
  }

  static List<List<int>> getSudokuFromStringList(List<String> stringlist) {
    if (stringlist == null || stringlist.length != 81) return null;

    List<List<int>> sudokuArray = [];
    for (int i = 0; i < stringlist.length; i++) {
      if (i % 9 == 0) {
        sudokuArray.add([]);
      }
      sudokuArray.last.add(int.parse(stringlist[i]));
    }

    return sudokuArray;
  }

  static bool isSudokuEqual(
      List<List<int>> actualValues, List<List<int>> resolution) {
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (actualValues[i][j] != resolution[i][j]) return false;
      }
    }

    return true;
  }

  static List<int> getSudokuSquareOfRowAndColumn(
      List<List<int>> sudokuGrid, int row, int column) {
    if (row < 3) {
      if (column < 3)
        return _getSquareValues(sudokuGrid, 0, 0);
      else if (column < 6)
        return _getSquareValues(sudokuGrid, 0, 3);
      else
        return _getSquareValues(sudokuGrid, 0, 6);
    } else if (row < 6) {
      if (column < 3)
        return _getSquareValues(sudokuGrid, 3, 0);
      else if (column < 6)
        return _getSquareValues(sudokuGrid, 3, 3);
      else
        return _getSquareValues(sudokuGrid, 3, 6);
    } else {
      if (column < 3)
        return _getSquareValues(sudokuGrid, 6, 0);
      else if (column < 6)
        return _getSquareValues(sudokuGrid, 6, 3);
      else
        return _getSquareValues(sudokuGrid, 6, 6);
    }
  }

  static List<int> _getSquareValues(List<List<int>> grid, int row, int column) {
    List<int> square = [];

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        square.add(grid[i + row][j + column]);
      }
    }

    return square;
  }
}
