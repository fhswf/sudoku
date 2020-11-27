import 'package:flutter/material.dart';
import 'dart:math';

class DialogHelper {
  static const int COUNTOFGIFS = 16;

  static String getRandomCongratsGif() {
    var random = new Random();
    int randomNumber = random.nextInt(COUNTOFGIFS);

    return "images/congrats_${randomNumber.toString()}.gif";
  }

  static Future<void> showWinDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
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
}
