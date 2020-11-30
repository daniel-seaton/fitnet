import 'package:fitnet/models/format.dart';
import 'package:fitnet/models/workoutStep.dart';
import 'package:fitnet/src/app/workout/editWorkoutScreen/formFields/editStep/editStepModal.dart';
import 'package:fitnet/src/app/workout/editWorkoutScreen/formFields/editStep/workStepChangeNotifier.dart';
import 'package:fitnet/src/app/workout/editWorkoutScreen/formFields/stepListItem.dart';
import 'package:fitnet/src/app/workout/editWorkoutScreen/workoutChangeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StepListField extends StatelessWidget {
  final List<WorkoutStep> steps;
  final Format defaultFormat;

  StepListField({@required this.steps, @required this.defaultFormat});

  @override
  Widget build(BuildContext context) {
    EditWorkoutChangeNotifier notifier =
        Provider.of<EditWorkoutChangeNotifier>(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 40,
            child: Text('Steps:', style: Theme.of(context).textTheme.bodyText1),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5)),
            height: MediaQuery.of(context).size.height / 2.1,
            width: MediaQuery.of(context).size.width - 40,
            child: ReorderableListView(
              onReorder: (x, y) {
                if (!notifier.isEdit) return;
                if (x != y) {
                  WorkoutStep step = notifier.removeStep(x);
                  notifier.addStep(step, index: y > x ? y - 1 : y);
                }
              },
              children: List.generate(
                steps.length,
                (index) {
                  return StepListItem(
                    key: Key(steps[index].exercise.name),
                    step: steps[index],
                    showStepModal: (step, isEdit) => showStepModal(context,
                        step: step,
                        isEdit: isEdit,
                        onSave: (WorkoutStep step) =>
                            notifier.addStep(step, index: index, isEdit: true)),
                    onDismissed: () => notifier.removeStep(index),
                  );
                },
              ),
            ),
          ),
          notifier.isEdit
              ? OutlineButton(
                  key: Key('addStepButton'),
                  color: Colors.grey,
                  onPressed: () => showStepModal(
                    context,
                    step: WorkoutStep.empty(),
                    isEdit: true,
                    onSave: (WorkoutStep step) => notifier.addStep(step),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.grey),
                      Text(
                        'Add Step',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                )
              : Container(key: Key('emptyContainer'), height: 0),
        ],
      ),
    );
  }

  showStepModal(BuildContext context,
      {@required Function onSave, WorkoutStep step, isEdit = false}) async {
    EditWorkoutChangeNotifier workoutChangeNotifier =
        Provider.of<EditWorkoutChangeNotifier>(context, listen: false);
    if (step.formatType == null) {
      step.formatType = workoutChangeNotifier.workout.defaultFormat.value;
      step = WorkoutStepFactory.getForType(
          workoutChangeNotifier.workout.defaultFormat.value, step.toMap());
    }

    await showDialog(
        context: context,
        builder: (context) => EditStepModal(
            notifier: WorkoutStepChangeNotifier(step: step),
            isEdit: isEdit,
            onSave: onSave));
  }
}
