import 'package:fitnet/models/format.dart';
import 'package:fitnet/models/workoutStep.dart';
import 'package:fitnet/src/app/workout/editWorkoutScreen/workoutChangeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StepListField extends StatelessWidget {
  final List<WorkoutStep> steps;
  final Format defaultFormat;

  StepListField({@required this.steps, @required this.defaultFormat});

  @override
  Widget build(BuildContext context) {
    WorkoutChangeNotifier changeNotifier =
        Provider.of<WorkoutChangeNotifier>(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Steps:', style: Theme.of(context).textTheme.bodyText1),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  IconButton(
                      padding: EdgeInsets.all(4),
                      iconSize: 18,
                      icon: Icon(Icons.add, color: Colors.grey),
                      onPressed: () {
                        print('TODO add step');
                      }),
                  IconButton(
                      padding: EdgeInsets.all(4),
                      iconSize: 18,
                      icon: Icon(Icons.remove, color: Colors.grey),
                      onPressed: () {
                        print('TODO remove step');
                      })
                ]),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5)),
            height: MediaQuery.of(context).size.height / 2.1,
            width: MediaQuery.of(context).size.width - 40,
            child: ReorderableListView(
              onReorder: (x, y) {
                if (x != y) {
                  WorkoutStep step = changeNotifier.removeStep(x);
                  changeNotifier.addStep(y > x ? y - 1 : y, step);
                }
              },
              children: List.generate(
                steps.length,
                (index) {
                  WorkoutStep step = steps[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.5),
                      ),
                    ),
                    key: Key(step.exercise.name),
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
                            Text(step.format.displayValue,
                                style: Theme.of(context).textTheme.bodyText2),
                          ],
                        ),
                        IconButton(icon: Icon(Icons.reorder), onPressed: null)
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
