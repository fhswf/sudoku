import 'package:flutter/material.dart';
import 'box.dart';
import 'package:tuple/tuple.dart';

class Sudoku extends StatefulWidget {
  List<List<dynamic>> twoDList;
  List<List<dynamic>> acutalValues;
  Function callback;
  Tuple2<int, int> selectedBox;

  Sudoku(
      {Key key,
      this.twoDList,
      this.acutalValues,
      this.callback,
      this.selectedBox})
      : super(key: key) {
    // Evtl. anstatt hier nur Zahlen in einem 2D Array zu speichern, eine Klasse SudokuKasten machen und dort die Zahl, Farben, Position, vonSpeilerGefüllt, RichtigeZahl speichern.
    this.twoDList = twoDList;
    this.acutalValues = acutalValues;
    this.callback = callback;
    this.selectedBox = selectedBox;
  }

  @override
  _SudokuState createState() => _SudokuState(twoDList, acutalValues);
}

class _SudokuState extends State<Sudoku> {
  List<List<Widget>>
      twoDWidgetList; // Evtl hier die Widgets abspeichern, zu den einzelnen Feldern
  List<List<dynamic>> twoDList;
  List<List<dynamic>> acutalValues;
  String actualText = "1";

  _SudokuState(List<List<dynamic>> twoDList, List<List<dynamic>> acutalValues) {
    this.twoDList = twoDList;
    this.acutalValues = acutalValues;
  }

  List<Widget> getSudokuFields() {
    List<Widget> fields = List<Widget>();

    for (int i = 0; i < 9; i++) {
      List<Widget> childs = List<Widget>();

      for (int j = 0; j < 9; j++) {
        bool isSelected =
            widget.selectedBox.item1 == i && widget.selectedBox.item2 == j;

        var box = Box(twoDList[i][j], Tuple2(i, j), widget.callback,
            value: acutalValues[i][j],
            isInitalValue: false,
            isSelected: isSelected);

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
