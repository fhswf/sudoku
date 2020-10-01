import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

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

  // Here goes the Methods
  List<Widget> createNumberButtons() {
    List<Widget> buttons = new List<Widget>();

    for (int i = 1; i <= 9; i++) {
      buttons.add(Expanded(
        child: RaisedButton(
          onPressed: () {},
          child: Text(i.toString(), style: TextStyle(fontSize: 20)),
          color: Colors.blue,
          textColor: Colors.white,
          elevation: 5,
        ),
      ));
    }

    buttons.add(Expanded(
      child: RaisedButton(
        onPressed: () {},
        child: Center(
          child: Icon(Icons.delete, size: 20),
        ),
        color: Colors.blue,
        textColor: Colors.white,
        elevation: 5,
      ),
    ));

    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Column(
          children: [
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
                      color: Colors.blue,
                      textColor: Colors.white,
                      elevation: 5,
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {},
                      child: const Text('Hint', style: TextStyle(fontSize: 20)),
                      color: Colors.blue,
                      textColor: Colors.white,
                      elevation: 5,
                    ),
                  ),
/*                  Schwierigkeitsgrad kann ausgewählt werden, wenn auf "New Game geklickt wird."
                    Expanded(
                    child: DropdownButton(
                        items: difficultyItems,
                        value: selectedDifficultyItem,
                        onChanged: (value) {
                          setState(() {
                            selectedDifficultyItem = value;
                          });
                        }),
                  ),*/
                ],
              ),
            ),
            Expanded(
              child: Container(color: Colors.grey),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: createNumberButtons(),
              ),
            ),
          ],
        ));
  }
}
