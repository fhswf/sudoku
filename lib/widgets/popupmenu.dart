import 'package:flutter/material.dart';
import 'package:sudoku/services/sudoku_service.dart';

class PopupMenu extends StatelessWidget {
  SudokuService _service;
  Function _callback;

  PopupMenu(SudokuService service, Function callback) {
    this._service = service;
    this._callback = callback;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<bool>(
      itemBuilder: (context) => [
        CheckedPopupMenuItem(
          child: Text('Help'),
          checked: _service.helpOn,
          value: _service.helpOn,
        ),
      ],
      onSelected: (value) {
        _callback(value);
      },
    );
  }
}
