import 'package:fitnet/models/customColors.dart';
import 'package:fitnet/routes/editWorkout/editWorkoutScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../workoutChangeNotifier.dart';

class NameField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EditWorkoutChangeNotifier notifier =
        Provider.of<EditWorkoutChangeNotifier>(context, listen: false);
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 250,
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Consumer<EditWorkoutChangeNotifier>(
              builder: (_, notifier, __) => TextFormField(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: CustomColors.white),
                  initialValue: notifier.workout.name ?? 'Enter Name',
                  onChanged: (value) => notifier.setName(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: validate),
            ),
          ),
        ],
      ),
    );
  }

  String validate(String value) {
    if (value == null || value == '' || value == 'Enter Name') return '';
    return null;
  }
}
