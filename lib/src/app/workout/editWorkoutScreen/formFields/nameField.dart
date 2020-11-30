import 'package:fitnet/src/app/workout/editWorkoutScreen/workoutChangeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                  readOnly: !notifier.isEdit,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: Colors.white),
                  initialValue: notifier.workout.name ?? 'Enter Name',
                  onChanged: (value) => notifier.setName(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: validate),
            ),
          ),
          !notifier.isEdit
              ? IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => notifier.setIsEdit(true),
                )
              : Container(height: 0, width: 0),
        ],
      ),
    );
  }

  String validate(String value) {
    if (value == null || value == '' || value == 'Enter Name') return '';
    return null;
  }
}
