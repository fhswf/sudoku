import 'package:flutter/material.dart';
import 'package:sudoku/widgets/sudoku.dart';
import 'package:tuple/tuple.dart';
import 'menubuttons.dart';
import 'numberbuttons.dart';
import '../services/sudoku_service.dart';

class HomePage extends StatefulWidget {
  final String title;

  Tuple2<int, int> selectedBox = Tuple2(-1, -1);

  SudokuService service = SudokuService(1);

  List<List<dynamic>> acutalValues = [
    [1, 2, 3, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 4, 5, 6, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 7, 8, 9],
  ];

  void initGame() {
    // Erstellt keine Tiefe Kopie
    // acutalValues = new List<List<dynamic>>.from(initialValues);
  }

  HomePage({Key key, this.title}) : super(key: key) {
    // initGame();
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<DropdownMenuItem> difficultyItems = <DropdownMenuItem>[
    DropdownMenuItem(child: Text("Easy"), value: 1),
    DropdownMenuItem(child: Text("Normal"), value: 2),
    DropdownMenuItem(child: Text("Hard"), value: 3),
  ];
  int selectedDifficultyItem = 1;

  void setNumber(int value) {
    setState(() => widget.acutalValues[widget.selectedBox.item1]
        [widget.selectedBox.item2] = value);
  }

  void changeSelected(Tuple2 tuple) {
    setState(() => widget.selectedBox = tuple);
  }

  void delete(Tuple2 tuple) {
    setState(() {
      widget.acutalValues[tuple.item1][tuple.item2] = 0;
      widget.selectedBox = tuple;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            //image: DecorationImage(
            //image: AssetImage("images/background.jpg"),
            // fit: BoxFit.cover,
            // ),
          ),
          child: Column(children: [
            MenuButtons(),
            Expanded(
              child: Sudoku(
                  resolution: widget.service.resolution,
                  acutalValues: widget.acutalValues,
                  initialValues: widget.service.initialValues,
                  callback: this.changeSelected,
                  delete: this.delete,
                  selectedBox: widget.selectedBox),
            ),
            NumberButtons(
              this.setNumber,
            ),
          ]),
        ));
  }
}
