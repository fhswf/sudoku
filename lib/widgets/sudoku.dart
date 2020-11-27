import 'package:flutter/material.dart';
import 'package:sudoku/services/sudoku_service.dart';
import 'box.dart';
import 'package:tuple/tuple.dart';

class Sudoku extends StatefulWidget {
  SudokuService sudokuService;
  Function callback;
  Function delete;
  Tuple2<int, int> selectedBox;

  Sudoku(
      {Key key,
      this.sudokuService,
      this.callback,
      this.delete,
      this.selectedBox})
      : super(key: key) {
    this.sudokuService = sudokuService;
    this.callback = callback;
    this.delete = delete;
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

        int actualValue = widget.sudokuService.getAcutalValuesValue(i, j);
        int initialValue = widget.sudokuService.getInitialValuesValue(i, j);
        var box = Box(widget.sudokuService.getResolutionValue(i, j),
            Tuple2(i, j), widget.callback, widget.delete,
            value: actualValue,
            isInitalValue: actualValue == initialValue && initialValue != 0,
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
