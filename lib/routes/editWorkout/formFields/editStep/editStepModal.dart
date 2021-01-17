import 'package:fitnet/utils/customColors.dart';
import 'package:fitnet/routes/editWorkout/formFields/editStep/workStepChangeNotifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'formFields/exerciseNameField.dart';
import 'formFields/exerciseTagField.dart';
import 'formFields/formatFieldFactory.dart';
import 'formFields/stepFormatField.dart';

class EditStepModal extends StatelessWidget {
  final isEdit;
  final Function onSave;
  final WorkoutStepChangeNotifier notifier;
  final _formKey = GlobalKey<FormState>();

  EditStepModal(
      {@required this.notifier, @required this.onSave, this.isEdit = false});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: notifier,
      builder: (ctx, __) => Dialog(
        backgroundColor: CustomColors.white,
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
                    color: CustomColors.blue,
                    child: Text(
                      isEdit ? 'Edit Step' : 'View Step',
                      style: TextStyle(color: CustomColors.white, fontSize: 24),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Selector<WorkoutStepChangeNotifier, String>(
                      selector: (_, notifier) => notifier.step.formatType,
                      builder: (_, formatType, __) => Column(
                        children: [
                          ExerciseNameField(
                            isEdit: isEdit,
                          ),
                          StepFormatField(isEdit: isEdit),
                          ...FormatFieldFactory.getFields(formatType, isEdit),
                          ExerciseTagField(isEdit: isEdit),
                          ElevatedButton(
                            onPressed: () {
                              bool isValid = _formKey.currentState.validate();
                              if (isEdit && isValid) {
                                onSave(notifier.step);
                                Navigator.of(context).pop();
                              } else if (!isEdit) {
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text(isEdit ? 'Save' : 'Close'),
                          ),
                        ],
                      ),
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
