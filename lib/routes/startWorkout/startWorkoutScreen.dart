import 'package:fitnet/utils/customColors.dart';
import 'package:fitnet/models/workoutInstance.dart';
import 'package:fitnet/shared/notifiers/instanceChangeNotifier.dart';
import 'package:fitnet/utils/timeUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class StartWorkoutScreen extends StatelessWidget {
  final WorkoutInstance instance;
  StartWorkoutScreen({@required this.instance});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InstanceChangeNotifier(instance),
      child: Consumer<InstanceChangeNotifier>(
        builder: (ctx, notifier, __) =>
          Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: CustomColors.white,
              ),
              onPressed: () => exit(ctx),
            ),
            centerTitle: true,
            title: Text(
              notifier.currentStepName ?? 'Complete',
              textAlign: TextAlign.center,
              style: TextStyle(color: CustomColors.white, fontSize: 36.0),
            ),
          ),
          body: Container(
            height: MediaQuery.of(ctx).size.height,
            width: MediaQuery.of(ctx).size.width,
            color: CustomColors.lightGrey,
            child: notifier.currentStep != null 
              ? notifier.getCurrentStepScreen()
              : Center(child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check, color: CustomColors.green, size: 72.0),
                      Text('Time: ${notifier.getTimeElapsed()}'),
                      ElevatedButton(
                        onPressed: () => exit(ctx),
                        child: Text(
                          'Done',
                          style: TextStyle(fontSize: 24.0),
                        ),
                      ),
                    ],
                  ),
                ),
          ),
        )
      ),
    );
  }

  void exit(BuildContext context) async {
    Navigator.of(context).pop(Provider.of<InstanceChangeNotifier>(context, listen: false).instance);
  }
}
