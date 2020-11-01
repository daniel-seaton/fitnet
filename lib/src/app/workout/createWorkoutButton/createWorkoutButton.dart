import 'package:fitnet/models/workout.dart';
import 'package:fitnet/src/app/workout/editWorkoutScreen/editWorkoutScreen.dart';
import 'package:flutter/material.dart';

class CreateWorkoutButton extends StatelessWidget {
  final String userId;

  CreateWorkoutButton({@required this.userId});

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      borderSide: BorderSide(color: Colors.grey, width: 1),
      color: Colors.grey,
      onPressed: () => showNewWorkoutScreen(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, color: Colors.grey),
          Text('Create New Workout', style: TextStyle(color: Colors.grey))
        ],
      ),
    );
  }

  showNewWorkoutScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditWorkoutScreen(
                  workout: Workout(uid: userId),
                  isEdit: true,
                )));
  }
}
