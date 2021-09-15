import 'package:fitnet/models/workout.dart';
import 'package:fitnet/models/workoutInstance.dart';
import 'package:fitnet/routes/startWorkout/startWorkoutScreen.dart';
import 'package:fitnet/shared/notifiers/listChangeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ViewWorkoutStartButton extends StatelessWidget {
  final Workout workout;

  ViewWorkoutStartButton({@required this.workout});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
      height: 100,
      width: 150,
      child: Consumer<ListChangeNotifier<WorkoutInstance>>(
        builder: (_, notifier, __) => ElevatedButton(
          onPressed: () => startWorkout(context, notifier.list),
          child: Text(
            getButtonText(notifier.list),
          ),
        ),
      ),
    );
  }

  String getButtonText(List<WorkoutInstance> instances) {
    return instances.length > 0 && !instances[0].isCompleted
        ? 'Resume Workout'
        : 'Start Workout';
  }

  void startWorkout(
      BuildContext context, List<WorkoutInstance> instances) async {
    WorkoutInstance instance = instances.length > 0 ? instances[0] : null;
    if (instance == null || instance.isCompleted) instance = WorkoutInstance.fromWorkout(workout);

    instance = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => StartWorkoutScreen(instance: instance)));

    var index = instances.indexWhere((i) => i.iid == instance.iid);
    var provider = Provider.of<ListChangeNotifier<WorkoutInstance>>(context, listen: false);
    if (index > -1 ) provider.update(instance, index);
    else provider.add(instance, 0);
  }
}
