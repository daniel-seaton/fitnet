import 'package:fitnet/models/workoutStepInstance.dart';
import 'package:fitnet/utils/customColors.dart';
import 'package:flutter/material.dart';

class SetBasedStepMetaDisplay extends StatelessWidget {
  final SetBasedStepInstance stepInstance;

  SetBasedStepMetaDisplay({@required this.stepInstance}) : super();

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.sync, color: CustomColors.grey),
            Icon(Icons.fitness_center, color: CustomColors.grey)
          ],
        ),
      ),
      ...List.generate(
        stepInstance.sets.length,
        (index) {
          return Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border(
                    right: index < stepInstance.sets.length - 1
                        ? BorderSide(color: CustomColors.lightGrey, width: 2)
                        : BorderSide.none)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('${stepInstance.sets[index].actual ?? '--'}',
                    style: Theme.of(context).textTheme.subtitle2),
                getWeightDisplay(context, index),
              ],
            ),
          );
        },
      ),
    ]);
  }

  Widget getWeightDisplay(BuildContext context, num index) {
    if (index == 0) {
      return Text('${stepInstance.sets[index].weight ?? '--'}',
          style: Theme.of(context).textTheme.subtitle2);
    } else if (stepInstance.sets[index].weight <
        stepInstance.sets[index - 1].weight) {
      return Icon(Icons.south, color: CustomColors.grey, size: 20);
    } else if (stepInstance.sets[index].weight >
        stepInstance.sets[index - 1].weight) {
      return Icon(Icons.north, color: CustomColors.grey, size: 20);
    } else {
      return Icon(Icons.horizontal_rule, color: CustomColors.grey, size: 20);
    }
  }
}
