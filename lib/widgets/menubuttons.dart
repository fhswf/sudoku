import 'package:flutter/material.dart';

class MenuButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.topCenter,
      heightFactor: 1,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: RaisedButton(
              onPressed: () {},
              child: const Text('New Game', style: TextStyle(fontSize: 20)),
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
    );
  }
}
