import 'package:flutter/material.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';
import 'package:provider/provider.dart';

import '../../../../../colors.dart';
import '../../SetsChangeNotifier.dart';

class CurrentSetDisplay extends StatelessWidget {
  CurrentSetDisplay();

  @override
  Widget build(BuildContext context) {
    return Consumer<SetsChangeNotifier>(
      builder: (_, notifier, __) => SingleCircularSlider(
        notifier.currentSet.goal,
        notifier.currentSet.actual % notifier.currentSet.goal,
        height: 400,
        width: 400,
        shouldCountLaps: true,
        baseColor: CustomColors.lightGrey,
        selectionColor: CustomColors.blue,
        onSelectionChange: (_, value, laps) => notifier.currentSet
                .isInProgress()
            ? notifier.setCurrentActual(value + notifier.currentSet.goal * laps)
            : null,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: CustomColors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(3, 5),
                  blurRadius: 9,
                  color: CustomColors.black)
            ],
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('${notifier.getTimeElapsed()}',
                style: TextStyle(fontSize: 36)),
            Text(
              '${notifier.currentSet.isInProgress() ? notifier.currentSet.actual : 'Rest'}',
              style: TextStyle(fontSize: 64),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              FlatButton(
                  minWidth: 8,
                  height: 30,
                  color: CustomColors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      bottomLeft: Radius.circular(24.0),
                    ),
                  ),
                  onPressed: () => notifier
                      .setCurrentWeight(notifier.currentSet.weight - 2.5),
                  child: Text('-',
                      style:
                          TextStyle(fontSize: 30, color: CustomColors.white))),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Text(
                  '${notifier.currentSet.weight}lbs',
                  style: TextStyle(fontSize: 36),
                ),
              ),
              FlatButton(
                  minWidth: 8,
                  height: 30,
                  color: CustomColors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24.0),
                      bottomRight: Radius.circular(24.0),
                    ),
                  ),
                  onPressed: () => notifier
                      .setCurrentWeight(notifier.currentSet.weight + 2.5),
                  child: Text('+',
                      style:
                          TextStyle(fontSize: 30, color: CustomColors.white)))
            ])
          ]),
        ),
      ),
    );
  }
}
