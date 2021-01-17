import 'package:flutter/material.dart';

import '../../../../../utils/customColors.dart';

class TagDisplay extends StatelessWidget {
  final String tag;

  TagDisplay({@required this.tag});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2),
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            '$tag',
            style: TextStyle(color: CustomColors.white, fontSize: 16),
          ),
        ),
        decoration: BoxDecoration(
          color: CustomColors.blue,
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
      ),
    );
  }
}
