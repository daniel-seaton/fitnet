import 'package:fitnet/models/workoutInstance.dart';
import 'package:fitnet/shared/notifiers/listChangeNotifier.dart';
import 'package:fitnet/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'workoutHistoryListItem/workoutHistoryListItem.dart';

class WorkoutHistoryStepList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ListChangeNotifier<WorkoutInstance>>(
      builder: (_, notifier, __) => Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: CustomColors.lightGrey,
          child: ListView.builder(
              itemCount: notifier.list.length,
              itemBuilder: (_, index) =>
                  WorkoutHistoryListItem(instance: notifier.list[index]))),
    );
  }
}
