import 'package:flutter/material.dart';

class CreateWorkoutButton extends StatelessWidget {
  final String userId;

  CreateWorkoutButton({@required this.userId});

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      borderSide: BorderSide(color: Colors.grey, width: 1),
      color: Colors.grey,
      onPressed: () => showNewWorkoutScreen(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, color: Colors.grey),
          Text('Create New Workout', style: TextStyle(color: Colors.grey))
        ],
      ),
    );
  }

  showNewWorkoutScreen() {
    print('TODO showNewWorkoutScreen');
  }
}
