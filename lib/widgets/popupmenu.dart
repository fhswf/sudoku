import 'package:flutter/material.dart';
import 'package:sudoku/services/sudoku_service.dart';

class PopupMenu extends StatelessWidget {
  final SudokuService _sudokuService;
  final _callback;

  PopupMenu(this._sudokuService, this._callback);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<bool>(
      itemBuilder: (context) => [
        CheckedPopupMenuItem(
          child: Text('Help'),
          checked: _sudokuService.helpOn,
          value: _sudokuService.helpOn,
        ),
      ],
      onSelected: (value) {
        _callback(value);
      },
    );
  }
}
