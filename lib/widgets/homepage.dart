import 'package:flutter/material.dart';
import 'package:sudoku/utility/dialoghelper.dart';
import 'package:tuple/tuple.dart';
import 'package:sudoku/utility/difficulty.dart';
import 'package:sudoku/utility/sudokuarray.dart';
import 'package:sudoku/widgets/sudoku.dart';
import 'package:sudoku/widgets/popupmenu.dart';
import 'package:sudoku/widgets/sidemenu.dart';
import 'package:sudoku/services/sudoku_service.dart';
import 'numberbuttons.dart';
import 'package:sudoku/utility/sudokupersister.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  final String title;
  final SudokuService _service = SudokuService();
  Tuple2<int, int> _selectedBox = Tuple2(-1, -1);

  HomePage({Key key, this.title}) : super(key: key) {
    _service.generateNewGame(Difficulty.Easy);
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _setNumber(int value) {
    if (widget._selectedBox.item1 != -1 && widget._selectedBox.item2 != -1)
      setState(() {
        widget._service.acutalValues[widget._selectedBox.item1]
            [widget._selectedBox.item2] = value;
        if (SudokuArray.isSudokuEqual(
            widget._service.acutalValues, widget._service.resolution)) {
          _resetSelected();
          widget._service.resetGame();
          var dialogHelper = DialogHelper(context);
          dialogHelper.showWinDialog();
        }
      });
  }

  void _changeSelected(Tuple2 tuple) {
    if (widget._service.acutalValues != null)
      setState(() => widget._selectedBox = tuple);
  }

  void _resetSelected() {
    var tuple = Tuple2(-1, -1);
    _changeSelected(tuple);
  }

  void _deleteNumber(Tuple2 tuple) {
    setState(() {
      widget._service.acutalValues[tuple.item1][tuple.item2] = 0;
      widget._selectedBox = tuple;
    });
  }

  void _newGame(Difficulty difficulty) {
    setState(() {
      _resetSelected();
      widget._service.generateNewGame(difficulty);
    });
  }

  void _saveGame() async {
    var dialogHelper = DialogHelper(context);
    SudokuPersister.saveSudoku(widget._service, dialogHelper);
  }

  void _loadGame() async {
    var dialogHelper = DialogHelper(context);
    SudokuPersister.loadSudoku(widget._service, dialogHelper).then((value) => {
          setState(() {
            _resetSelected();
          })
        });
  }

  void _setHelp(bool value) {
    setState(() => widget._service.helpOn = !value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenu(widget._service, _setHelp),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(children: [
          Expanded(
            child: Sudoku(widget._service, _changeSelected, _deleteNumber,
                widget._selectedBox),
          ),
          NumberButtons(
            _setNumber,
          ),
        ]),
      ),
      drawer: Drawer(
        child: SideMenu(_newGame, _saveGame, _loadGame),
      ),
    );
  }
}
