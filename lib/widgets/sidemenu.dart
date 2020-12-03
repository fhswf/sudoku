import 'package:flutter/material.dart';
import 'package:sudoku/utility/difficulty.dart';

class SideMenu extends StatelessWidget {
  final Function _newGame;
  final Function _saveGame;
  final Function _loadGame;

  SideMenu(this._newGame, this._saveGame, this._loadGame);

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
              _newGame(Difficulty.Easy);
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
              _newGame(Difficulty.Normal);
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
              _newGame(Difficulty.Hard);
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
              _saveGame();
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
              _loadGame();
            },
          ),
        ],
      ),
    );
  }
}
