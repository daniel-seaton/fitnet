import 'package:fitnet/utils/customColors.dart';
import 'package:fitnet/models/format.dart';
import 'package:fitnet/models/workoutInstance.dart';
import 'package:fitnet/models/workoutStepInstance.dart';
import 'package:fitnet/routes/startWorkout/repsForTimeStepScreen/repsForTimeStepScreen.dart';
import 'package:fitnet/routes/startWorkout/setBasedStepScreen/setBasedStepScreen.dart';
import 'package:fitnet/routes/startWorkout/stepsChangeNotifier.dart';
import 'package:fitnet/services/workoutInstanceService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../serviceInjector.dart';
import 'amrapStepScreen/amrapStepsScreen.dart';

class StartWorkoutScreen extends StatelessWidget {
  final WorkoutInstance instance;
  final WorkoutInstanceService instanceService =
      injector<WorkoutInstanceService>();
  StartWorkoutScreen({@required this.instance});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StepsChangeNotifier(steps: instance.steps),
      child: Consumer<StepsChangeNotifier>(
        builder: (ctx, notifier, __) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: CustomColors.white,
              ),
              onPressed: () => updateAndExit(ctx, complete: false),
            ),
            centerTitle: true,
            title: Text(
              notifier.currentStep.exerciseName,
              textAlign: TextAlign.center,
              style: TextStyle(color: CustomColors.white, fontSize: 36.0),
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

  void updateAndExit(BuildContext context, {bool complete = false}) async {
    StepsChangeNotifier notifier =
        Provider.of<StepsChangeNotifier>(context, listen: false);
    if (complete) instance.end = DateTime.now();
    instance.steps = notifier.steps;
    await instanceService.updateInstance(instance);
    Navigator.of(context).pop();
  }

  void nextStep(BuildContext context) async {
    StepsChangeNotifier notifier =
        Provider.of<StepsChangeNotifier>(context, listen: false);
    notifier.nextStep();
    if (notifier.currentIndex == notifier.steps.length) {
      updateAndExit(context, complete: true);
    }
  }

  Widget getBodyForStep(WorkoutStepInstance step, Function nextStep) {
    switch (step.format.value) {
      case FormatType.SetBased:
        return SetBasedStepScreen(
          step: step as SetBasedStepInstance,
          nextStep: nextStep,
        );
      case FormatType.RepsForTime:
        return RepsForTimeStepScreen(step: step as RepsForTimeStepInstance);
      case FormatType.AMRAP:
        return AMRAPStepScreen(
            step: step as AMRAPStepInstance, nextStep: nextStep);
      default:
        return Container();
    }
  }
}
