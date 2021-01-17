import 'package:fitnet/utils/customColors.dart';
import 'package:fitnet/models/workout.dart';
import 'package:fitnet/models/workoutInstance.dart';
import 'package:fitnet/models/workoutStep.dart';
import 'package:fitnet/routes/editWorkout/editWorkoutScreen.dart';
import 'package:fitnet/routes/startWorkout/startWorkoutScreen.dart';
import 'package:fitnet/shared/progressCircle.dart';
import 'package:fitnet/shared/timeElapsedNotifier.dart';
import 'package:fitnet/services/workoutInstanceService.dart';
import 'package:fitnet/shared/workoutStepListItem.dart';
import 'package:fitnet/utils/timeUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../serviceInjector.dart';

class ViewWorkoutScreen extends StatelessWidget {
  final WorkoutInstanceService instanceService =
      injector<WorkoutInstanceService>();
  final Workout workout;

  ViewWorkoutScreen({@required this.workout});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<WorkoutInstance>>(
      initialData: [],
      create: (_) => instanceService.getInstancesStreamByWid(workout.wid),
      builder: (ctx, _) => Scaffold(
        appBar: AppBar(
          title: ViewWorkoutTitle(workout: workout),
        ),
        body: Column(
          children: [
            Expanded(flex: 6, child: ViewWorkoutStepList(steps: workout.steps)),
            Selector<List<WorkoutInstance>, bool>(
              selector: (_, instances) => instances.length > 0,
              child:
                  Expanded(flex: 3, child: ViewWorkoutLatestInstanceDisplay()),
              builder: (_, displayLatestInstance, child) =>
                  displayLatestInstance
                      ? child
                      : Container(
                          width: 0.0,
                          height: 0.0,
                        ),
            ),
            Expanded(
                flex: 1,
                child: ViewWorkoutStartButton(
                  workout: workout,
                ))
          ],
        ),
      ),
    );
  }
}

class ViewWorkoutLatestInstanceDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(15, 15, 0, 5),
          child: Selector<List<WorkoutInstance>, WorkoutInstance>(
            selector: (_, instances) => instances[0],
            builder: (_, latestInstance, __) => Text(
                latestInstance.isCompleted()
                    ? 'Last Workout:'
                    : 'In Progress Workout:',
                style: Theme.of(context).textTheme.bodyText1),
          ),
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width - 30,
            decoration: BoxDecoration(
              color: CustomColors.white,
              border: Border.all(color: CustomColors.grey, width: 0.5),
            ),
            margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
            padding: EdgeInsets.all(10),
            child: Selector<List<WorkoutInstance>, WorkoutInstance>(
                selector: (_, instances) => instances[0],
                builder: (_, latestInstance, __) => latestInstance.isCompleted()
                    ? CompletedInstanceDisplay(instance: latestInstance)
                    : InProgressInstanceDisplay(instance: latestInstance)),
          ),
        ),
      ],
    );
  }
}

class InProgressInstanceDisplay extends StatelessWidget {
  final WorkoutInstanceService instanceService =
      injector<WorkoutInstanceService>();
  final WorkoutInstance instance;

  InProgressInstanceDisplay({@required this.instance});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ProgressCircle(
          completionPercentage: instance.percentComplete(),
          completeColor:
              CustomColors.getColorForCompletion(instance.percentComplete()),
          incompleteColor: CustomColors.lightGrey,
          strokeWidth: 5,
          size: 100,
          child: Text(
            '${instance.percentComplete()}%',
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        ChangeNotifierProvider<TimeElapsedNotifier>.value(
          value: TimeElapsedNotifier(instance.start),
          builder: (ctx, _) => Consumer<TimeElapsedNotifier>(
            builder: (_, notifier, __) => Text(
              'In Progress\nTime Elapsed: ${notifier.getTimeElapsed()}',
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.highlight_off, color: CustomColors.red, size: 36),
          onPressed: () => confirmCompleteWorkout(context),
        )
      ],
    );
  }

  confirmCompleteWorkout(BuildContext context) async {
    var completeWorkout = await showDialog<bool>(
        context: context, builder: (context) => ConfirmCompleteWorkoutModal());
    if (completeWorkout) {
      instance.end = DateTime.now();
      await instanceService.updateInstance(instance);
    }
  }
}

class ConfirmCompleteWorkoutModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: CustomColors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Confirm',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, color: CustomColors.white),
              ),
            ),
            Text('Are you sure you would like to complete this workout early?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                  child: Text('Confirm',
                      style: TextStyle(color: CustomColors.blue, fontSize: 18)),
                  onPressed: () => {Navigator.of(context).pop(true)},
                ),
                FlatButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: CustomColors.red, fontSize: 18),
                  ),
                  onPressed: () => {Navigator.of(context).pop(false)},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CompletedInstanceDisplay extends StatelessWidget {
  final WorkoutInstance instance;

  CompletedInstanceDisplay({@required this.instance});
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      ProgressCircle(
        completionPercentage: instance.percentComplete(),
        completeColor:
            CustomColors.getColorForCompletion(instance.percentComplete()),
        incompleteColor: CustomColors.lightGrey,
        strokeWidth: 5,
        size: 100,
        child: Text(
          '${instance.percentComplete()}%',
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ),
      Text(
        'Completed: ${TimeUtil.getTimeBeforeNowString(instance.end)}\nTime Elapsed: ${TimeUtil.getElapsedTimeString(instance.end.difference(instance.start))}',
        style: Theme.of(context).textTheme.subtitle2,
      ),
      IconButton(
        icon: Icon(Icons.more_horiz, color: CustomColors.grey, size: 36),
        onPressed: () => {print('TODO')},
      )
    ]);
  }
}

class ViewWorkoutStartButton extends StatelessWidget {
  final WorkoutInstanceService instanceService =
      injector<WorkoutInstanceService>();

  final Workout workout;

  ViewWorkoutStartButton({@required this.workout});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
      height: 100,
      width: 150,
      child: Consumer<List<WorkoutInstance>>(
        builder: (_, instances, __) => ElevatedButton(
          onPressed: () => startWorkout(context, instances),
          child: Text(
            getButtonText(instances),
          ),
        ),
      ),
    );
  }

  String getButtonText(List<WorkoutInstance> instances) {
    return instances.length > 0 && instances[0].end == null
        ? 'Resume Workout'
        : 'Start Workout';
  }

  void startWorkout(
      BuildContext context, List<WorkoutInstance> instances) async {
    WorkoutInstance instance = instances.length > 0 ? instances[0] : null;
    if (instance == null || instance.isCompleted())
      instance = await instanceService.addNewInstance(workout);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => StartWorkoutScreen(instance: instance)));
  }
}

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
                  showStepModal: null),
            ),
          ),
        ),
      ],
    );
  }
}

class ViewWorkoutTitle extends StatelessWidget {
  final Workout workout;

  ViewWorkoutTitle({@required this.workout});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 265,
            child: Text(
              workout.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: CustomColors.white,
              ),
            ),
          ),
          IconButton(
              icon: Icon(Icons.edit, color: CustomColors.white),
              onPressed: () => editWorkout(context))
        ],
      ),
    );
  }

  void editWorkout(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => EditWorkoutScreen(workout: workout)));
  }
}
