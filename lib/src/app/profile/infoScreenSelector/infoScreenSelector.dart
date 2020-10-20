import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../infoWidgetProvider.dart';

class InfoScreenSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    InfoWidgetProvider widgetProvider =
        Provider.of<InfoWidgetProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FlatButton(
          onPressed: () => widgetProvider.select(0),
          minWidth: 150,
          child: Text(
            'My Info',
            style: TextStyle(
                color: widgetProvider.userInfoSelected()
                    ? Colors.white
                    : Colors.blue),
          ),
          color: widgetProvider.userInfoSelected() ? Colors.blue : Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6.0),
                bottomLeft: Radius.circular(6.0),
              ),
              side: widgetProvider.userInfoSelected()
                  ? BorderSide.none
                  : BorderSide(color: Colors.blue)),
        ),
        Container(width: 1, height: 1),
        SelectorButton(
            label: 'My Stats',
            onPressed: () => widgetProvider.select(1),
            selected: !widgetProvider.userInfoSelected(),
            right: true),
      ],
    );
  }
}

class SelectorButton extends StatelessWidget {
  final bool left;
  final bool right;
  final bool selected;
  final String label;
  final Function onPressed;

  SelectorButton(
      {@required this.selected,
      @required this.label,
      @required this.onPressed,
      this.left = false,
      this.right = false});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      minWidth: 150,
      child: Text(
        label,
        style: TextStyle(color: selected ? Colors.white : Colors.blue),
      ),
      color: selected ? Colors.blue : Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: left ? Radius.circular(6.0) : Radius.zero,
            topRight: right ? Radius.circular(6.0) : Radius.zero,
            bottomLeft: left ? Radius.circular(6.0) : Radius.zero,
            bottomRight: right ? Radius.circular(6.0) : Radius.zero,
          ),
          side: selected ? BorderSide.none : BorderSide(color: Colors.blue)),
    );
  }
}
