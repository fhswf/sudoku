import 'package:flutter/material.dart';
import 'package:sudoku/services/sudoku_service.dart';
import 'package:sudoku/utility/difficulty.dart';

class SideMenu extends StatelessWidget {
  SudokuService sudokuService;
  Function newGame;
  Function saveGame;
  Function loadGame;

  SideMenu(SudokuService sudokuService, Function newGame, Function saveGame,
      Function loadGame) {
    this.sudokuService = sudokuService;
    this.newGame = newGame;
    this.saveGame = saveGame;
    this.loadGame = loadGame;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      // Important: Remove any padding from the ListView.
      //padding: EdgeInsets.zero,
      children: <Widget>[
        ListTile(
          title: Text('Start Easy Game'),
          onTap: () {
            newGame(Difficulty.Easy);
            // ToDo
            // Später entfernen, sowie das Sudokuservice aus der Klasse entfernen
            sudokuService.acutalValues = sudokuService.resolution;
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Start Normal Game'),
          onTap: () {
            newGame(Difficulty.Normal);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Start Hard Game'),
          onTap: () {
            newGame(Difficulty.Hard);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Save Game'),
          onTap: () {
            saveGame();
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Load Game'),
          onTap: () {
            loadGame();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
