import 'package:flutter/material.dart';

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
