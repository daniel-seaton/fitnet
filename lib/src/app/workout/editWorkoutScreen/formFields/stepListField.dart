import 'package:fitnet/models/format.dart';
import 'package:fitnet/models/workoutStep.dart';
import 'package:fitnet/src/app/workout/editWorkoutScreen/editChangeNotifier.dart';
import 'package:fitnet/src/app/workout/editWorkoutScreen/formFields/editStep/editStepModal.dart';
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
    WorkoutChangeNotifier workoutNotifier =
        Provider.of<WorkoutChangeNotifier>(context, listen: false);
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
            child: Consumer<EditChangeNotifier>(
              builder: (_, editNotifier, __) => ReorderableListView(
                onReorder: (x, y) {
                  if (!editNotifier.isEdit) return;
                  if (x != y) {
                    WorkoutStep step = workoutNotifier.removeStep(x);
                    workoutNotifier.addStep(step, index: y > x ? y - 1 : y);
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
                          onSave: (WorkoutStep step) => workoutNotifier
                              .addStep(step, index: index, isEdit: true)),
                      onDismissed: () => workoutNotifier.removeStep(index),
                    );
                  },
                ),
              ),
            ),
          ),
          Consumer<EditChangeNotifier>(
            builder: (_, editNotifier, __) => editNotifier.isEdit
                ? OutlineButton(
                    key: Key('addStepButton'),
                    color: Colors.grey,
                    onPressed: () => showStepModal(
                      context,
                      isEdit: true,
                      onSave: (WorkoutStep step) =>
                          workoutNotifier.addStep(step),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.grey),
                        Text('Add Step', style: TextStyle(color: Colors.grey))
                      ],
                    ),
                  )
                : Container(key: Key('emptyContainer'), height: 0),
          )
        ],
      ),
    );
  }

  showStepModal(BuildContext context,
      {@required Function onSave, WorkoutStep step, isEdit = false}) async {
    WorkoutChangeNotifier workoutChangeNotifier =
        Provider.of<WorkoutChangeNotifier>(context, listen: false);
    if (step == null) {
      step = WorkoutStep.empty();
      step.format = workoutChangeNotifier.workout.defaultFormat;
      step.formatType = step.format.value;
    }

    await showDialog(
        context: context,
        builder: (context) =>
            EditStepModal(step: step, isEdit: isEdit, onSave: onSave));
  }
}
