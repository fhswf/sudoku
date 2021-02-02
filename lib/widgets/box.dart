import 'package:flutter/material.dart';
import 'package:sudoku/services/sudoku_service.dart';
import 'package:tuple/tuple.dart';

class Box extends StatefulWidget {
  // 0 means, box is not filled
  final int _value;
  // Save whether the value is already filled when the game starts.
  final bool _isInitalValue;
  final int _solutionValue;
  final Tuple2<int, int> _position;
  final Function _callback;
  final Function _deleteNumber;
  final SudokuService _sudokuService;
  final bool _isSelected;

  Box(this._solutionValue, this._position, this._callback, this._deleteNumber,
      this._sudokuService, this._value, this._isInitalValue, this._isSelected);

  bool _correctAnswer() {
    return _value == _solutionValue;
  }

  String _getValue() {
    if (_value == 0) return '';
    return _value.toString();
  }

  Color _getBackgroundColorForBox() {
    var color = Colors.white.withOpacity(0.1);

    if (_isInitalValue) {
      return color;
    } else if (_isSelected) {
      return Color.fromRGBO(8, 145, 207, 1).withOpacity(0.5);
    } else if (_sudokuService.helpOn && _value != 0) {
      color = _correctAnswer() ? Colors.green : Colors.red;
    }

    return color;
  }

  Color _getBorderColor() {
    return Colors.blue[800];
  }

  @override
  _BoxState createState() => _BoxState();
}

class _BoxState extends State<Box> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (!widget._isInitalValue) widget._callback(widget._position);
        },
        onLongPress: () {
          if (!widget._isInitalValue) widget._deleteNumber(widget._position);
        },
        child: Container(
          decoration: BoxDecoration(
            color: widget._getBackgroundColorForBox(),
            border: Border(
              top: BorderSide(
                color: widget._getBorderColor(),
                width: widget._position.item1 % 3 != 0
                    ? 1.0
                    : widget._position.item1 == 0
                        ? 4.0
                        : 3.0,
              ),
              right: BorderSide(
                color: widget._getBorderColor(),
                width: widget._position.item2 == 8 ? 4.0 : 0.0,
              ),
              bottom: BorderSide(
                color: widget._getBorderColor(),
                width: widget._position.item1 == 8 ? 4.0 : 0.0,
              ),
              left: BorderSide(
                color: widget._getBorderColor(),
                width: widget._position.item2 % 3 != 0
                    ? 1.0
                    : widget._position.item2 == 0
                        ? 4.0
                        : 3.0,
              ),
            ),
          ),
          child: Center(
            child: Text(
              widget._getValue(),
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: widget._isInitalValue
                      ? FontWeight.bold
                      : FontWeight.normal),
            ),
          ),
        ),
      ),
    );
  }
}
