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

  Tuple2<int, int> position;

  Box(int solutionValue, Tuple2<int, int> position,
      {int value = 0, bool isInitalValue = false}) {
    this.solutionValue = solutionValue;
    this.value = value;
    this.isInitalValue = isInitalValue;
    this.position = position;
  }

  // Gibt zurück, ob der aktuelle Wert richtig ist.
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
  void updateValue(int value) {
    // Frage, muss ich das immer in einem setState aufrufen, damit der Wert sich in der UI aktualisiert?
    // Mal ausprobieren
    setState(() => widget.value = value);
  }

  @override
  Widget build(BuildContext context) {
    int counter = 0;
    return Expanded(
      child: InkWell(
        onTap: () {
          // Evtl. muss ich das in einer Klasse vorher machen. Dort wo ich speichere, welche Box gerade selektiert ist.
          counter++;
          print("Tapped a Container" + counter.toString());
        },
        child: Container(
          decoration: BoxDecoration(
            color: widget.correctAnswer() ? Colors.green : Colors.red,
            border: Border(
              top: BorderSide(
                //                    <--- top side
                color: Colors.black,
                width: widget.position.item1 % 3 != 0
                    ? 1.0
                    : widget.position.item1 == 0 ? 4.0 : 3.0,
              ),
              right: BorderSide(
                //                   <--- left side
                color: Colors.black,
                width: widget.position.item2 == 8 ? 4.0 : 0.0,
              ),
              bottom: BorderSide(
                //                    <--- top side
                color: Colors.black,
                width: widget.position.item1 == 8 ? 4.0 : 0.0,
              ),
              left: BorderSide(
                //                   <--- left side
                color: Colors.black,
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
