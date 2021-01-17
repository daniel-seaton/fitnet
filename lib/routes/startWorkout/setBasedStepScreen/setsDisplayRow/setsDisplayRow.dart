import 'package:fitnet/utils/customColors.dart';
import 'package:fitnet/utils/timeUtil.dart';
import 'package:flutter/material.dart';
import 'package:fitnet/models/set.dart';
import 'package:provider/provider.dart';

import '../../setsChangeNotifier.dart';

class SetsDisplayRow extends StatelessWidget {
  SetsDisplayRow();

  @override
  Widget build(BuildContext context) {
    SetsChangeNotifier setsNotifier =
        Provider.of<SetsChangeNotifier>(context, listen: false);
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: setsNotifier.sets.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Consumer<SetsChangeNotifier>(
          builder: (_, notifier, __) => Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: CustomColors.darkGrey,
                          blurRadius: 4,
                          offset: Offset(1, 3))
                    ],
                    color: getRingColor(notifier.sets[index]),
                    shape: BoxShape.circle),
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: CustomColors.white, shape: BoxShape.circle),
              ),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
              ])
            ],
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
      return s.goalMet() ? CustomColors.green : CustomColors.red;
    }
    if (s.isInProgress()) {
      return CustomColors.blue;
    }
    return CustomColors.lightGrey;
  }
}
