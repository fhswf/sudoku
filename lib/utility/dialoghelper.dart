import 'package:flutter/material.dart';
import 'dart:math';

import 'package:sudoku/services/sudoku_service.dart';

class DialogHelper {
  final int _countOfGifs = 16;
  BuildContext _context;

  DialogHelper(BuildContext context) {
    this._context = context;
  }

  String getRandomCongratsGif() {
    var random = new Random();
    int randomNumber = random.nextInt(_countOfGifs);

    return "images/congrats_${randomNumber.toString()}.gif";
  }

  Future<void> showWinDialog() async {
    return showDialog<void>(
      context: this._context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You have successfully solved the Sudoku.'),
                Image.asset(
                  getRandomCongratsGif(),
                  height: 250.0,
                  width: 250.0,
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          backgroundColor: Colors.green,
        );
      },
    );
  }

  Future<void> showSaveDialog(Function callback, SudokuService service) async {
    return showDialog<void>(
      context: this._context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Save Sudoku?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you really want to save the current Sudoku.'),
                Text('If you have saved a other game, it will be overwritten.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Save'),
              onPressed: () {
                callback(service);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          backgroundColor: Colors.blue,
        );
      },
    );
  }

  Future<void> showLoadFailureDialog() async {
    return showDialog<void>(
      context: this._context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Loading failed!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You have not saved a game yet.'),
                Text('Please start a new game.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          backgroundColor: Colors.orange,
        );
      },
    );
  }
}
