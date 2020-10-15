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

  Box(int solutionValue, Tuple2<int, int> position, Function callback,
      {int value = 0, bool isInitalValue = false, bool isSelected = false}) {
    this.solutionValue = solutionValue;
    this.value = value;
    this.isInitalValue = isInitalValue;
    this.position = position;
    this.callback = callback;
    this.isSelected = isSelected;
  }

  // Gibt zurück, ob der aktuelle Wert richtig ist.
  bool correctAnswer() {
    return this.value == this.solutionValue;
  }

  String getValue() {
    if (this.value == 0) return '';
    return this.value.toString();
  }

//  MaterialColor getBorderColor() {
//    if (isInitalValue) return Colors.red;
//   if (isSelected) return Colors.blue;
//  }

  @override
  _BoxState createState() => _BoxState();
}

class _BoxState extends State<Box> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          widget.callback(widget.position);
        },
        onLongPress: () {
          if (!widget.isInitalValue) {/* Wert löschen */}
        },
        child: Container(
          decoration: BoxDecoration(
            color: widget.correctAnswer() ? Colors.green : null,
            border: Border(
              top: BorderSide(
                //                    <--- top side
                color: widget.isSelected ? Colors.blue : Colors.black,
                width: widget.position.item1 % 3 != 0
                    ? 1.0
                    : widget.position.item1 == 0 ? 4.0 : 3.0,
              ),
              right: BorderSide(
                //                   <--- left side
                color: widget.isSelected ? Colors.blue : Colors.black,
                width: widget.position.item2 == 8 ? 4.0 : 0.0,
              ),
              bottom: BorderSide(
                //                    <--- top side
                color: widget.isSelected ? Colors.blue : Colors.black,
                width: widget.position.item1 == 8 ? 4.0 : 0.0,
              ),
              left: BorderSide(
                //                   <--- left side
                color: widget.isSelected ? Colors.blue : Colors.black,
                width: widget.position.item2 % 3 != 0
                    ? 1.0
                    : widget.position.item2 == 0 ? 4.0 : 3.0,
              ),
            ),
          ), //       <--- BoxDecoration here
          child: Center(
            child: Text(
              widget.getValue(),
              style: TextStyle(fontSize: 30.0),
            ),
          ),
        ),
      ),
    );
  }
}
