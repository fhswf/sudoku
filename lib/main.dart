import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sudoku',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Sudoku'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<DropdownMenuItem> difficultyItems = <DropdownMenuItem>[
    DropdownMenuItem(
      child: Text("Easy"),
      value: 1,
    ),
    DropdownMenuItem(
      child: Text("Normal"),
      value: 2,
    ),
    DropdownMenuItem(child: Text("Hard"), value: 3),
  ];
  int selectedDifficultyItem = 1;

  // Here goes the Methods

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
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {},
                      child: const Text('1', style: TextStyle(fontSize: 20)),
                      color: Colors.blue,
                      textColor: Colors.white,
                      elevation: 5,
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {},
                      child: const Text('2', style: TextStyle(fontSize: 20)),
                      color: Colors.blue,
                      textColor: Colors.white,
                      elevation: 5,
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {},
                      child: const Text('3', style: TextStyle(fontSize: 20)),
                      color: Colors.blue,
                      textColor: Colors.white,
                      elevation: 5,
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {},
                      child: const Text('4', style: TextStyle(fontSize: 20)),
                      color: Colors.blue,
                      textColor: Colors.white,
                      elevation: 5,
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {},
                      child: const Text('5', style: TextStyle(fontSize: 20)),
                      color: Colors.blue,
                      textColor: Colors.white,
                      elevation: 5,
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {},
                      child: const Text('6', style: TextStyle(fontSize: 20)),
                      color: Colors.blue,
                      textColor: Colors.white,
                      elevation: 5,
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {},
                      child: const Text('7', style: TextStyle(fontSize: 20)),
                      color: Colors.blue,
                      textColor: Colors.white,
                      elevation: 5,
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {},
                      child: const Text('8', style: TextStyle(fontSize: 20)),
                      color: Colors.blue,
                      textColor: Colors.white,
                      elevation: 5,
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {},
                      child: const Text('9', style: TextStyle(fontSize: 20)),
                      color: Colors.blue,
                      textColor: Colors.white,
                      elevation: 5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
