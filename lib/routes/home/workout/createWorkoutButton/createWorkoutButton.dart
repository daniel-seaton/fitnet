import 'package:fitnet/models/workout.dart';
import 'package:fitnet/routes/editWorkout/editWorkoutScreen.dart';
import 'package:flutter/material.dart';

import '../../../../models/customColors.dart';

class CreateWorkoutButton extends StatelessWidget {
  final String userId;

  CreateWorkoutButton({@required this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 3,
                color: CustomColors.darkGrey)
          ],
          color: CustomColors.white,
        ),
        child: FlatButton(
          onPressed: () => showNewWorkoutScreen(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: CustomColors.grey),
              Text('Create New Workout',
                  style: TextStyle(color: CustomColors.grey, fontSize: 24))
            ],
          ),
        ),
      ),
    );
  }

  showNewWorkoutScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditWorkoutScreen(
          workout: Workout(uid: userId),
        ),
      ),
    );
  }
}
