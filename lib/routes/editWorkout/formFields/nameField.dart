import 'package:fitnet/utils/customColors.dart';
import 'package:fitnet/shared/notifiers/workoutChangeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NameField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EditWorkoutChangeNotifier notifier =
        Provider.of<EditWorkoutChangeNotifier>(context);
    return TextFormField(
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24, color: CustomColors.white),
        initialValue: notifier.workout.name ?? 'Enter Name',
        onChanged: (value) => notifier.setName(value),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validate);
  }

  String validate(String value) {
    if (value == null || value == '' || value == 'Enter Name') return '';
    return null;
  }
}
