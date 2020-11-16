import 'package:fitnet/models/format.dart';
import 'package:fitnet/models/workoutStep.dart';
import 'package:fitnet/src/app/workout/editWorkoutScreen/editChangeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    EditChangeNotifier editNotifier = Provider.of<EditChangeNotifier>(context);
    return Dismissible(
      key: key,
      direction: editNotifier.isEdit ? DismissDirection.horizontal : null,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (dir) {
        if (editNotifier.isEdit) onDismissed();
      },
      child: InkWell(
        onTap: () => showStepModal(step, editNotifier.isEdit),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey, width: 0.5),
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
              editNotifier.isEdit
                  ? IconButton(icon: Icon(Icons.reorder), onPressed: null)
                  : Container(width: 0, height: 0)
            ],
          ),
        ),
      ),
    );
  }
}
