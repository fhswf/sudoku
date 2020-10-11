import 'package:flutter/material.dart';
import 'box.dart';
import 'package:tuple/tuple.dart';
import 'dart:math';

class Sudoku extends StatefulWidget {
  List<List<dynamic>> twoDList;

  Sudoku({Key key, this.twoDList}) : super(key: key) {
    // Evtl. anstatt hier nur Zahlen in einem 2D Array zu speichern, eine Klasse SudokuKasten machen und dort die Zahl, Farben, Position, vonSpeilerGefüllt, RichtigeZahl speichern.
    twoDList = List.generate(9, (i) => List(9), growable: false);
    for (int i = 0; i < twoDList.length; i++) {
      for (int j = 0; j < twoDList.length; j++) {
        twoDList[i][j] = i + j;
      }
    }
  }

  @override
  _SudokuState createState() => _SudokuState(twoDList);
}

class _SudokuState extends State<Sudoku> {
  List<List<Widget>>
      twoDWidgetList; // Evtl hier die Widgets abspeichern, zu den einzelnen Feldern
  List<List<dynamic>> twoDList;
  String actualText = "1";

  _SudokuState(List<List<dynamic>> list) {
    this.twoDList = list;
  }

  List<Widget> getSudokuFields() {
    List<Widget> fields = List<Widget>();

    for (int i = 0; i < 9; i++) {
      List<Widget> childs = List<Widget>();

      for (int j = 0; j < 9; j++) {
        var rng = new Random();

        var box = Box(twoDList[i][j], Tuple2(i, j),
            value: rng.nextInt(10), isInitalValue: false);

        childs.add(box);
      }

      fields.add(
        Row(
          children: childs,
        ),
      );
    }

    return fields;
  }

  @override
  Widget build(BuildContext context) {
    var column = Column(
      children: getSudokuFields(),
    );

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: column,
      ),
    );
  }
}
