import 'package:flutter/material.dart';
import 'package:sudoku/services/sudoku_service.dart';
import 'box.dart';
import 'package:tuple/tuple.dart';

class Sudoku extends StatefulWidget {
  final SudokuService _sudokuService;
  final Function _callback;
  final Function _deleteNumber;
  final Tuple2<int, int> _selectedBox;

  Sudoku(this._sudokuService, this._callback, this._deleteNumber,
      this._selectedBox,
      {Key key})
      : super(key: key);

  @override
  _SudokuState createState() => _SudokuState();
}

class _SudokuState extends State<Sudoku> {
  List<Widget> _getSudokuFields() {
    List<Widget> fields = List<Widget>();

    for (int i = 0; i < 9; i++) {
      List<Widget> childs = List<Widget>();

      for (int j = 0; j < 9; j++) {
        bool isSelected =
            widget._selectedBox.item1 == i && widget._selectedBox.item2 == j;

        int actualValue = widget._sudokuService.getAcutalValuesValue(i, j);
        int initialValue = widget._sudokuService.getInitialValuesValue(i, j);
        var box = Box(
            widget._sudokuService.getResolutionValue(i, j),
            Tuple2(i, j),
            widget._callback,
            widget._deleteNumber,
            widget._sudokuService,
            actualValue,
            actualValue == initialValue && initialValue != 0,
            isSelected);

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
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Column(
          children: _getSudokuFields(),
        ),
      ),
    );
  }
}
