import 'package:fitnet/models/workoutStep.dart';
import 'package:fitnet/routes/editWorkout/formFields/editStep/editStepModal.dart';
import 'package:fitnet/routes/editWorkout/formFields/editStep/workStepChangeNotifier.dart';
import 'package:fitnet/shared/workoutStepListItem.dart';
import 'package:fitnet/utils/customColors.dart';
import 'package:flutter/material.dart';

class ViewWorkoutStepList extends StatelessWidget {
  final List<WorkoutStep> steps;

  ViewWorkoutStepList({@required this.steps});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(15, 15, 0, 5),
          child: Text('Steps:', style: Theme.of(context).textTheme.bodyText1),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
            decoration: BoxDecoration(
                color: CustomColors.lightGrey,
                border: Border.all(color: CustomColors.grey, width: 0.5)),
            child: ListView.builder(
              itemCount: steps.length,
              itemBuilder: (ctx, index) => WorkoutStepListItem(
                key: Key(steps[index].exercise.name),
                step: steps[index],
                isEdit: false,
                showStepModal: (step, isEdit) =>
                    showStepModal(context, step: step),
              ),
            ),
          ),
        ),
      ],
    );
  }

  showStepModal(
    BuildContext context, {
    WorkoutStep step,
  }) async {
    await showDialog(
        context: context,
        builder: (context) => EditStepModal(
              notifier: WorkoutStepChangeNotifier(step: step),
              isEdit: false,
              onSave: () {},
            ));
  }
}
