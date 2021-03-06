import 'package:flutter/material.dart';

class NumberButtons extends StatelessWidget {
  final Function _setNumber;

  NumberButtons(this._setNumber);

  List<Widget> _createNumberButtons() {
    List<Widget> buttons = List<Widget>();
    List<Widget> aligns = List<Widget>();

    for (int i = 1; i <= 9; i++) {
      buttons.add(
        Expanded(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: BorderSide(color: Colors.blue[900], width: 2)),
            onPressed: () {
              _setNumber(i);
            },
            child: Text((i).toString(), style: TextStyle(fontSize: 20)),
            color: Colors.blue[600],
            textColor: Colors.black,
            elevation: 1,
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
    return Column(
      children: _createNumberButtons(),
    );
  }
}
