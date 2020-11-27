class SudokuArray {
  static int getValueFromSudokuArray(
      List<List<dynamic>> grid, int row, int column) {
    if (grid == null) return 0;
    return grid[row][column];
  }

  static List<List<dynamic>> duplicateGrid(List<List<dynamic>> grid) {
    List<List<dynamic>> copyGrid = [];
    for (var row in grid) {
      copyGrid.add([]);
      for (var col in row) {
        copyGrid.last.add(col);
      }
    }

    return copyGrid;
  }

  static List<dynamic> getSquareValues(
      List<List<dynamic>> grid, int row, int column) {
    List<dynamic> square = [];

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        square.add(grid[i + row][j + column]);
      }
    }

    return square;
  }

  // A function to check if the grid is full
  static bool checkGrid(List<List<dynamic>> grid) {
    // return !grid.contains(0); // Prüfen ob das funktioniert
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid.length; j++) {
        if (grid[i][j] == 0) return false;
      }
    }

    // We have a complete grid!
    return true;
  }

  static List<String> getSudokuAsStringList(List<List<dynamic>> sudoku) {
    List<String> stringlist = [];

    sudoku.forEach((element) {
      element.forEach((element) {
        stringlist.add(element.toString());
      });
    });

    return stringlist;
  }

  static List<List<dynamic>> getSudokuFromStringList(List<String> stringlist) {
    if (stringlist.length != 81) return null;

    List<List<dynamic>> sudokuArray = [];
    for (int i = 0; i < stringlist.length; i++) {
      if (i % 9 == 0) {
        sudokuArray.add([]);
      }
      sudokuArray.last.add(int.parse(stringlist[i]));
    }

    return sudokuArray;
  }

  static bool isSudokuEqual(
      List<List<dynamic>> actualValues, List<List<dynamic>> resolution) {
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (actualValues[i][j] != resolution[i][j]) return false;
      }
    }

    return true;
  }
}
