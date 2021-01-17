import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../infoWidgetProvider.dart';
import 'selectorButton.dart';

class InfoScreenSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    InfoWidgetProvider widgetProvider =
        Provider.of<InfoWidgetProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SelectorButton(
            label: 'My Info',
            onPressed: () => widgetProvider.select(0),
            selected: widgetProvider.userInfoSelected(),
            left: true),
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
