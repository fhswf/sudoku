import 'package:flutter/material.dart';
import 'box.dart';
import 'package:tuple/tuple.dart';

class Sudoku extends StatefulWidget {
  List<List<dynamic>> resolution;
  List<List<dynamic>> acutalValues;
  List<List<dynamic>> initialValues;
  Function callback;
  Tuple2<int, int> selectedBox;

  Sudoku(
      {Key key,
      this.resolution,
      this.acutalValues,
      this.initialValues,
      this.callback,
      this.selectedBox})
      : super(key: key) {
    this.resolution = resolution;
    this.acutalValues = acutalValues;
    this.initialValues = initialValues;
    this.callback = callback;
    this.selectedBox = selectedBox;
  }

  @override
  _SudokuState createState() => _SudokuState();
}

class _SudokuState extends State<Sudoku> {
  _SudokuState() {}

  List<Widget> getSudokuFields() {
    List<Widget> fields = List<Widget>();

    for (int i = 0; i < 9; i++) {
      List<Widget> childs = List<Widget>();

      for (int j = 0; j < 9; j++) {
        bool isSelected =
            widget.selectedBox.item1 == i && widget.selectedBox.item2 == j;

        var box = Box(widget.resolution[i][j], Tuple2(i, j), widget.callback,
            value: widget.acutalValues[i][j],
            isInitalValue:
                widget.acutalValues[i][j] == widget.initialValues[i][j] &&
                    widget.initialValues[i][j] != 0,
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
