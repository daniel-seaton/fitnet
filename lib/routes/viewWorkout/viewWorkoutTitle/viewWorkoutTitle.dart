import 'package:fitnet/models/workout.dart';
import 'package:fitnet/routes/editWorkout/editWorkoutScreen.dart';
import 'package:fitnet/utils/customColors.dart';
import 'package:flutter/material.dart';

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
