import 'package:fitnet/models/customColors.dart';
import 'package:fitnet/models/format.dart';
import 'package:fitnet/models/workoutStep.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../workoutChangeNotifier.dart';

class StepListItem extends StatelessWidget {
  final Key key;
  final WorkoutStep step;
  final Function showStepModal;
  final Function onDismissed;

  StepListItem(
      {@required this.key,
      @required this.step,
      @required this.showStepModal,
      @required this.onDismissed});

  @override
  Widget build(BuildContext context) {
    EditWorkoutChangeNotifier notifier =
        Provider.of<EditWorkoutChangeNotifier>(context);
    return Dismissible(
      key: key,
      direction: DismissDirection.horizontal,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
        color: CustomColors.red,
        child: Icon(Icons.delete, color: CustomColors.white),
      ),
      onDismissed: (dir) => onDismissed(),
      child: InkWell(
        onTap: () => showStepModal(step),
        child: Container(
          decoration: BoxDecoration(
            color: CustomColors.white,
            border: Border(
              bottom: BorderSide(color: CustomColors.grey, width: 0.5),
            ),
          ),
          padding: EdgeInsets.all(10),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(step.exercise.name,
                      style: Theme.of(context).textTheme.bodyText1),
                  Text(Format.forType(step.formatType).displayValue,
                      style: Theme.of(context).textTheme.bodyText2),
                ],
              ),
              Icon(Icons.reorder, color: CustomColors.grey)
            ],
          ),
        ),
      ),
    );
  }
}
