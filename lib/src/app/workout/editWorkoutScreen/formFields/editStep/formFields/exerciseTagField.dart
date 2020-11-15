import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../workStepChangeNotifier.dart';

class ExerciseTagField extends StatelessWidget {
  final bool isEdit;

  ExerciseTagField({@required this.isEdit});
  @override
  Widget build(BuildContext context) {
    WorkoutStepChangeNotifier notifier =
        Provider.of<WorkoutStepChangeNotifier>(context, listen: false);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
          width: MediaQuery.of(context).size.width / 6,
          child: Text('Tags:',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyText1),
        ),
        Container(
          child: Selector<WorkoutStepChangeNotifier, List<String>>(
            selector: (_, notifier) => notifier.step.exercise.tags,
            builder: (_, tags, __) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                  tags.length,
                  (index) => Row(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        width: MediaQuery.of(context).size.width / 2.25,
                        child: TextFormField(
                          readOnly: !isEdit,
                          initialValue: tags[index],
                          onChanged: (value) => notifier.setTag(value, index),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value == '')
                              return 'Tag cannot be empty';
                            return null;
                          },
                        ),
                      ),
                      isEdit
                          ? IconButton(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              onPressed: () => notifier.removeTag(index),
                              icon: Icon(Icons.close, color: Colors.grey),
                            )
                          : Container(height: 0, width: 0)
                    ],
                  ),
                ),
                isEdit
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: ElevatedButton(
                            child: Text('Add'),
                            onPressed: () => notifier.addTag()),
                      )
                    : Container(width: 0, height: 0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
