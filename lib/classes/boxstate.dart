import 'package:tuple/tuple.dart';

/// Speichert den aktuellen Status eines Kästchens in dem Sudokufeld.
class BoxState {
  // Aktueller Wert in dem Kästchen.
  // 0 bedeutet Kästchen ist nicht gefüllt.
  int value;

  // Wert der Lösung.
  int solutionValue;

  // Speichern, ob der Wert beim Start des Spiels bereits gefüllt ist.
  bool isInitalValue;

  Tuple2<int, int> position;

  BoxState(int solutionValue, Tuple2<int, int> position,
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

  void updateValue(int value) {
    // Frage, muss ich das immer in einem setState aufrufen, damit der Wert sich in der UI aktualisiert?
    //setState(() =>
    this.value = value;
    //);
  }
}
