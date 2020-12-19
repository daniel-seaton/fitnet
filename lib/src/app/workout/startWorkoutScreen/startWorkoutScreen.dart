import 'package:fitnet/models/format.dart';
import 'package:fitnet/models/set.dart';
import 'package:fitnet/models/workout.dart';
import 'package:fitnet/models/workoutStep.dart';
import 'package:fitnet/services/workoutService.dart';
import 'package:fitnet/src/app/workout/startWorkoutScreen/repsForTimeStepScreen/repsForTimeStepScreen.dart';
import 'package:fitnet/src/app/workout/startWorkoutScreen/setBasedStepScreen/setBasedStepScreen.dart';
import 'package:fitnet/src/app/workout/startWorkoutScreen/stepsChangeNotifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../serviceInjector.dart';
import '../../../colors.dart';
import 'amrapStepScreen/amrapStepsScreen.dart';

class StartWorkoutScreen extends StatelessWidget {
  final Workout workout;
  final WorkoutService workoutService = injector<WorkoutService>();
  StartWorkoutScreen({@required this.workout});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StepsChangeNotifier(steps: workout.steps),
      child: Consumer<StepsChangeNotifier>(
        builder: (ctx, notifier, __) => Scaffold(
          appBar: AppBar(
            title: Container(
              width: 250,
              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Text(
                notifier.currentStep.exercise.name,
                textAlign: TextAlign.center,
                style: TextStyle(color: CustomColors.white, fontSize: 36.0),
              ),
            ),
          ),
          body: Container(
              height: MediaQuery.of(ctx).size.height,
              width: MediaQuery.of(ctx).size.width,
              color: CustomColors.lightGrey,
              child: getBodyForStep(notifier.currentStep, () => nextStep(ctx))),
        ),
      ),
    );
  }

  void nextStep(BuildContext context) async {
    StepsChangeNotifier notifier =
        Provider.of<StepsChangeNotifier>(context, listen: false);
    notifier.nextStep();
    if (notifier.currentIndex == notifier.steps.length) {
      workout.end = DateTime.now();
      workout.steps = notifier.steps;
      await workoutService.addOrUpdateWorkout(workout);
      Navigator.of(context).pop();
    }
  }

  Widget getBodyForStep(WorkoutStep step, Function nextStep) {
    switch (step.format.value) {
      case FormatType.SetBased:
        return SetBasedStepScreen(
          step: step as SetBasedStep,
          nextStep: nextStep,
        );
      case FormatType.RepsForTime:
        return RepsForTimeStepScreen(step: step as RepsForTimeStep);
      case FormatType.AMRAP:
        return AMRAPStepScreen(step: step as AMRAPStep, nextStep: nextStep);
      default:
        return Container();
    }
  }
}
