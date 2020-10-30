import 'package:flutter/material.dart';
import 'package:sudoku/widgets/sudoku.dart';
import 'package:tuple/tuple.dart';

class HomePage extends StatefulWidget {
  final String title;

  Tuple2<int, int> selectedBox = Tuple2(-1, -1);

  List<List<dynamic>> resolution = [
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
  ];

  List<List<dynamic>> acutalValues = [
    [1, 2, 3, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 4, 5, 6, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 7, 8, 9],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
  ];

  final List<List<dynamic>> initialValues = [
    [1, 2, 3, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 4, 5, 6, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 7, 8, 9],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
  ];

  void initGame() {
    // Erstellt keine Tiefe Kopie
    // acutalValues = new List<List<dynamic>>.from(initialValues);
  }

  HomePage({Key key, this.title}) : super(key: key) {
    initGame();
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

  // Auslagen in ein Statless Widget
  List<Widget> createNumberButtons() {
    List<Widget> buttons = List<Widget>();
    List<Widget> aligns = List<Widget>();

    for (int i = 1; i <= 9; i++) {
      buttons.add(
        Expanded(
          child: RaisedButton(
            onPressed: () {
              setNumber(i);
            },
            child: Text((i).toString(), style: TextStyle(fontSize: 20)),
            color: Colors.orange,
            textColor: Colors.black,
            elevation: 5,
          ),
        ),
      );

      if (i % 3 == 0) {
        aligns.add(
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: buttons,
            ),
          ),
        );

        buttons = List<Widget>();
      }
    }

    return aligns;
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
            Align(
              alignment: FractionalOffset.topCenter,
              heightFactor: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {},
                      child: const Text('New Game',
                          style: TextStyle(fontSize: 20)),
                      color: Colors.orange,
                      textColor: Colors.black,
                      elevation: 5,
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {},
                      child: const Text('Hint', style: TextStyle(fontSize: 20)),
                      color: Colors.orange,
                      textColor: Colors.black,
                      elevation: 5,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Sudoku(
                  resolution: widget.resolution,
                  acutalValues: widget.acutalValues,
                  initialValues: widget.initialValues,
                  callback: this.changeSelected,
                  selectedBox: widget.selectedBox),
            ),
            Column(
              children: createNumberButtons(),
            )
          ]),
        ));
  }
}
