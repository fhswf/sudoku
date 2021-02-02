import 'package:sudoku/services/sudoku_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/utility/dialoghelper.dart';
import 'sudokuarray.dart';

class SudokuPersister {
  static const String INITIALVALUES = 'initialValues';
  static const String RESOLUTION = 'resolution';
  static const String ACTUALVALUES = 'actualValues';

  static void saveSudoku(
      SudokuService sudokuService, DialogHelper dialogHelper) async {
    dialogHelper.showSaveDialog(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (sudokuService.initialValues == null ||
          sudokuService.resolution == null ||
          sudokuService.acutalValues == null) return;

      prefs.setStringList(INITIALVALUES,
          SudokuArray.getSudokuAsStringList(sudokuService.initialValues));
      prefs.setStringList(RESOLUTION,
          SudokuArray.getSudokuAsStringList(sudokuService.resolution));
      prefs.setStringList(ACTUALVALUES,
          SudokuArray.getSudokuAsStringList(sudokuService.acutalValues));
    }, sudokuService);
  }

  static Future loadSudoku(
      SudokuService sudokuService, DialogHelper dialogHelper) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    sudokuService.initialValues =
        SudokuArray.getSudokuFromStringList(prefs.getStringList(INITIALVALUES));
    sudokuService.resolution =
        SudokuArray.getSudokuFromStringList(prefs.getStringList(RESOLUTION));
    sudokuService.acutalValues =
        SudokuArray.getSudokuFromStringList(prefs.getStringList(ACTUALVALUES));

    if (sudokuService.initialValues == null ||
        sudokuService.resolution == null ||
        sudokuService.acutalValues == null) {
      sudokuService.resetGame();

      dialogHelper.showLoadFailureDialog();
    }
  }
}
