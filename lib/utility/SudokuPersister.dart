import 'package:sudoku/services/sudoku_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utility/sudokuarray.dart';

class SudokuPersister {
  static const String INITIALVALUES = 'initialValues';
  static const String RESOLUTION = 'resolution';
  static const String ACTUALVALUES = 'actualValues';

  static void saveSudoku(SudokuService sudokuService) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setStringList(INITIALVALUES,
        SudokuArray.getSudokuAsStringList(sudokuService.initialValues));
    prefs.setStringList(RESOLUTION,
        SudokuArray.getSudokuAsStringList(sudokuService.resolution));
    prefs.setStringList(ACTUALVALUES,
        SudokuArray.getSudokuAsStringList(sudokuService.acutalValues));
  }

  static Future<List<List<dynamic>>> loadSudoku(
      SudokuService sudokuService) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    sudokuService.initialValues =
        SudokuArray.getSudokuFromStringList(prefs.getStringList(INITIALVALUES));
    sudokuService.resolution =
        SudokuArray.getSudokuFromStringList(prefs.getStringList(RESOLUTION));
    var acutalValues =
        SudokuArray.getSudokuFromStringList(prefs.getStringList(ACTUALVALUES));

    return acutalValues;
  }
}
