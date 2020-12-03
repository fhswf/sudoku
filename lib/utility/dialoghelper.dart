import 'package:flutter/material.dart';
import 'dart:math';
import 'package:sudoku/services/sudoku_service.dart';

class DialogHelper {
  final int _countOfGifs = 16;
  final BuildContext _context;

  DialogHelper(this._context);

  String _getRandomCongratsGif() {
    var random = new Random();
    var randomNumber = random.nextInt(_countOfGifs);

    return "images/congrats_${randomNumber.toString()}.gif";
  }

  Future<void> showWinDialog() async {
    return showDialog<void>(
      context: _context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You have successfully solved the Sudoku.'),
                Image.asset(
                  _getRandomCongratsGif(),
                  height: 250.0,
                  width: 250.0,
                )
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              child: Text('Ok'),
              textColor: Colors.black,
              color: Colors.green[900],
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
      context: _context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Save Sudoku?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you really want to save the current Sudoku.'),
                Text(
                    'If you have already saved another game, it will be overwritten.'),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              child: Text('Save'),
              color: Colors.yellow[700],
              textColor: Colors.black,
              onPressed: () {
                callback(service);
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              child: Text('Cancel'),
              color: Colors.yellow[700],
              textColor: Colors.black,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          backgroundColor: Colors.yellow,
        );
      },
    );
  }

  Future<void> showLoadFailureDialog() async {
    return showDialog<void>(
      context: _context,
      barrierDismissible: false,
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
            RaisedButton(
              child: Text('Ok'),
              color: Colors.red[800],
              textColor: Colors.black,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          backgroundColor: Colors.red,
        );
      },
    );
  }
}
