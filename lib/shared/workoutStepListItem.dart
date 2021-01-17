import 'package:fitnet/utils/customColors.dart';
import 'package:fitnet/models/format.dart';
import 'package:fitnet/models/workoutStep.dart';
import 'package:flutter/material.dart';

class WorkoutStepListItem extends StatelessWidget {
  final Key key;
  final WorkoutStep step;
  final Function showStepModal;
  final Function onDismissed;
  final bool isEdit;

  WorkoutStepListItem(
      {@required this.key,
      @required this.step,
      @required this.isEdit,
      @required this.showStepModal,
      this.onDismissed}) {
    if (this.isEdit && this.onDismissed == null) {
      throw new Exception('onDismissed must be defined if isEdit is true');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key,
      direction: DismissDirection.horizontal,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
        color: CustomColors.red,
        child: Icon(Icons.delete, color: CustomColors.white),
      ),
      onDismissed: (dir) => isEdit ? onDismissed() : null,
      child: InkWell(
        onTap: () => showStepModal(step),
        child: Container(
          decoration: BoxDecoration(
            color: CustomColors.white,
            border: Border(
              bottom: BorderSide(color: CustomColors.grey, width: 0.5),
            ),
          ),
          padding: EdgeInsets.all(10),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(step.exercise.name,
                      style: Theme.of(context).textTheme.bodyText1),
                  Text(Format.forType(step.formatType).displayValue,
                      style: Theme.of(context).textTheme.bodyText2),
                ],
              ),
              isEdit
                  ? Icon(
                      Icons.reorder,
                      color: CustomColors.lightGrey,
                    )
                  : Container(width: 0, height: 0)
            ],
          ),
        ),
      ),
    );
  }
}
