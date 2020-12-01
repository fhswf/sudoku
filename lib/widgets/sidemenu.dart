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
    return Container(
      decoration: BoxDecoration(
        image: new DecorationImage(
          image: AssetImage("images/sidemenu.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              'Start Easy Game',
              style: new TextStyle(
                fontSize: 18.0,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              newGame(Difficulty.Easy);
            },
          ),
          ListTile(
            title: Text(
              'Start Normal Game',
              style: new TextStyle(
                fontSize: 18.0,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              newGame(Difficulty.Normal);
            },
          ),
          ListTile(
            title: Text(
              'Start Hard Game',
              style: new TextStyle(
                fontSize: 18.0,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              newGame(Difficulty.Hard);
            },
          ),
          ListTile(
            title: Text(
              'Save Game',
              style: new TextStyle(
                fontSize: 18.0,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              saveGame();
            },
          ),
          ListTile(
            title: Text(
              'Load Game',
              style: new TextStyle(
                fontSize: 18.0,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              loadGame();
            },
          ),
        ],
      ),
    );
  }
}
