import 'package:fitnet/models/format.dart';
import 'package:fitnet/models/workoutStep.dart';
import 'package:fitnet/src/app/workout/editWorkoutScreen/formFields/editStep/workStepChangeNotifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'formFields/exerciseNameField.dart';
import 'formFields/exerciseTagField.dart';
import 'formFields/stepFormatField.dart';

class EditStepModal extends StatelessWidget {
  final WorkoutStep step;
  final isEdit;
  final Function onSave;
  final _formKey = GlobalKey<FormState>();

  EditStepModal(
      {@required this.step, @required this.onSave, this.isEdit = false});

  @override
  Widget build(BuildContext context) {
    WorkoutStepChangeNotifier notifier = WorkoutStepChangeNotifier(step: step);
    return ChangeNotifierProvider.value(
      value: notifier,
      builder: (_, __) => Dialog(
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 100,
            width: MediaQuery.of(context).size.width - 50,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 50,
                    width: MediaQuery.of(context).size.width - 50,
                    color: Colors.blue,
                    child: Text(
                      isEdit ? 'Edit Step' : 'View Step',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ExerciseNameField(
                          isEdit: isEdit,
                        ),
                        StepFormatField(isEdit: isEdit),
                        ExerciseTagField(isEdit: isEdit),
                        ElevatedButton(
                          onPressed: () {
                            bool isValid = _formKey.currentState.validate();
                            if (isEdit && isValid) {
                              onSave(notifier.step);
                              Navigator.pop(context);
                            } else if (!isEdit) {
                              Navigator.pop(context);
                            }
                          },
                          child: Text(isEdit ? 'Save' : 'Close'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
