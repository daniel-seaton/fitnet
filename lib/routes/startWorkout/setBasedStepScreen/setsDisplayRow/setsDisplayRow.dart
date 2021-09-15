import 'package:fitnet/shared/progressCircle/progressCircle.dart';
import 'package:fitnet/utils/customColors.dart';
import 'package:fitnet/utils/timeUtil.dart';
import 'package:flutter/material.dart';
import 'package:fitnet/models/set.dart';
import 'package:provider/provider.dart';

import '../../../../shared/notifiers/setsChangeNotifier.dart';

class SetsDisplayRow extends StatelessWidget {
  SetsDisplayRow();

  @override
  Widget build(BuildContext context) {
    return Consumer<SetsChangeNotifier>(
      builder: (_, notifier, __) => ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: notifier.sets.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: ProgressCircle(
          completionPercentage: notifier.sets[index].percentComplete(),
          completeColor: getRingColor(notifier.sets[index]),
          incompleteColor: notifier.currentSetIndex == index && notifier.currentSet.isInProgress()
                  ? CustomColors.blue
                  : CustomColors.lightGrey,
          strokeWidth: 7,
          size: 110,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(getTimeElapsed(notifier.sets[index]),
                    style: TextStyle(fontSize: 16)),
                Text(
                  '${notifier.sets[index].isComplete() ? notifier.sets[index].actual : 0}',
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  '${notifier.sets[index].weight}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getTimeElapsed(Set s) {
    if (!s.isComplete()) return '--:--';
    Duration elapsedTime = s.end.difference(s.start);
    return TimeUtil.getElapsedTimeString(elapsedTime);
  }

  Color getRingColor(Set s) {
    if (s.isComplete()) {
      return CustomColors.getColorForCompletion(s.percentComplete());
    }
    if (s.isInProgress()) {
      return CustomColors.blue;
    }
    return CustomColors.lightGrey;
  }
}
