import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

/// Speichert den aktuellen Status eines Kästchens in dem Sudokufeld.
class Box extends StatefulWidget {
  // Aktueller Wert in dem Kästchen.
  // 0 bedeutet Kästchen ist nicht gefüllt.
  int value;

  // Wert der Lösung.
  int solutionValue;

  // Speichern, ob der Wert beim Start des Spiels bereits gefüllt ist.
  bool isInitalValue;

  bool isSelected;

  Tuple2<int, int> position;

  Function callback;

  Function delete;

  Box(int solutionValue, Tuple2<int, int> position, Function callback,
      Function delete,
      {int value = 0, bool isInitalValue = false, bool isSelected = false}) {
    this.solutionValue = solutionValue;
    this.value = value;
    this.isInitalValue = isInitalValue;
    this.position = position;
    this.callback = callback;
    this.delete = delete;
    this.isSelected = isSelected;
  }

  bool correctAnswer() {
    return this.value == this.solutionValue;
  }

  String getValue() {
    if (this.value == 0) return '';
    return this.value.toString();
  }

  @override
  _BoxState createState() => _BoxState();
}

class _BoxState extends State<Box> {
  @override
  Widget build(BuildContext context) {
    double marginLeft = 0;
    double marginTop = 0;
    double marginRight = 0;
    double marginBottom = 0;

    return Expanded(
      child: InkWell(
        onTap: () {
          if (!widget.isInitalValue) widget.callback(widget.position);
        },
        onLongPress: () {
          if (!widget.isInitalValue) widget.delete(widget.position);
        },
        child: Container(
          margin: EdgeInsets.only(
              left: marginLeft,
              top: marginTop,
              right: marginRight,
              bottom: marginBottom),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? Color.fromRGBO(8, 145, 207, 1)
                : Color.fromRGBO(217, 163, 0, 1),
            border: Border(
              top: BorderSide(
                //                    <--- top side
                color: Color.fromRGBO(109, 81, 0, 1),
                width: widget.position.item1 % 3 != 0
                    ? 1.0
                    : widget.position.item1 == 0
                        ? 4.0
                        : 3.0,
              ),
              right: BorderSide(
                //                   <--- left side
                color: Color.fromRGBO(109, 81, 0, 1),
                width: widget.position.item2 == 8 ? 4.0 : 0.0,
              ),
              bottom: BorderSide(
                //                    <--- top side
                color: Color.fromRGBO(109, 81, 0, 1),
                width: widget.position.item1 == 8 ? 4.0 : 0.0,
              ),
              left: BorderSide(
                //                   <--- left side
                color: Color.fromRGBO(109, 81, 0, 1),
                width: widget.position.item2 % 3 != 0
                    ? 1.0
                    : widget.position.item2 == 0
                        ? 4.0
                        : 3.0,
              ),
            ),
          ), //       <--- BoxDecoration here
          child: Center(
            child: Text(
              widget.getValue(),
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: widget.isInitalValue
                      ? FontWeight.bold
                      : FontWeight.normal),
            ),
          ),
        ),
      ),
    );
  }
}
