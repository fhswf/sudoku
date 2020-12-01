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
import 'package:sudoku/utility/SudokuPersister.dart';

class HomePage extends StatefulWidget {
  final String title;

  Tuple2<int, int> selectedBox = Tuple2(-1, -1);

  SudokuService service = SudokuService();

  HomePage({Key key, this.title}) : super(key: key) {
    service.generateNewGame(difficulty: Difficulty.Easy);
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void setNumber(int value) {
    if (widget.selectedBox.item1 != -1 && widget.selectedBox.item2 != -1)
      setState(() {
        widget.service.acutalValues[widget.selectedBox.item1]
            [widget.selectedBox.item2] = value;
        if (SudokuArray.isSudokuEqual(
            widget.service.acutalValues, widget.service.resolution)) {
          resetSelected();
          widget.service.acutalValues = null;
          widget.service.resetGame();
          var dialogHelper = DialogHelper(context);
          dialogHelper.showWinDialog();
        }
      });
  }

  void changeSelected(Tuple2 tuple) {
    if (widget.service.acutalValues != null)
      setState(() => widget.selectedBox = tuple);
  }

  void resetSelected() {
    Tuple2<int, int> tuple = Tuple2(-1, -1);
    changeSelected(tuple);
  }

  void delete(Tuple2 tuple) {
    setState(() {
      widget.service.acutalValues[tuple.item1][tuple.item2] = 0;
      widget.selectedBox = tuple;
    });
  }

  void newGame(Difficulty difficulty) {
    setState(() {
      resetSelected();
      widget.service.generateNewGame(difficulty: difficulty);
    });
  }

  void saveGame() async {
    var dialogHelper = DialogHelper(context);
    await dialogHelper
        .showWinDialog(); // ToDo BUG!!! Ich darf diese Zeile nicht entfernen, sonst wird der SaveDialog nicht mehr angezeigt.
    await dialogHelper.showSaveDialog(
        SudokuPersister.saveSudoku, widget.service);
  }

  void loadGame() async {
    var dialogHelper = DialogHelper(context);
    SudokuPersister.loadSudoku(widget.service, dialogHelper).then((value) => {
          setState(() {
            resetSelected();
          })
        });
  }

  void setHelp(bool value) {
    setState(() => widget.service.helpOn = !value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenu(widget.service, setHelp),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          //color: Colors.blue[200],
          image: DecorationImage(
            image: AssetImage("images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(children: [
          Expanded(
            child: Sudoku(
                sudokuService: widget.service,
                callback: this.changeSelected,
                delete: this.delete,
                selectedBox: widget.selectedBox),
          ),
          NumberButtons(
            this.setNumber,
          ),
        ]),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: SideMenu(widget.service, newGame, saveGame, loadGame),
      ),
    );
  }

  void test(context) {
    Scaffold.of(context).openDrawer();
  }

  /* @override
  void initState() {
    super.initState();
    print('hello girl');

    WidgetsBinding.instance.addPostFrameCallback((_) => test(context));
  }*/
}
