import 'package:flutter/material.dart';

class PopupMenu extends StatelessWidget {
  bool helpOn;

  PopupMenu(bool helpOn) {
    this.helpOn = helpOn;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<bool>(
      itemBuilder: (context) => [
        CheckedPopupMenuItem(
          child: Text('Help'),
          checked: helpOn,
          value: helpOn,
        ),
      ],
      onCanceled: () {
        print("You have canceled the menu.");
      },
      onSelected: (value) {
        print("value:$value");
        helpOn = !value;
      },
    );
  }
}
