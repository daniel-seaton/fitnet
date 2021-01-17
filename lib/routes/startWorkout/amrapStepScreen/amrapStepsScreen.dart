import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:fitnet/models/workoutStepInstance.dart';
import 'package:fitnet/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';
import 'package:provider/provider.dart';

import '../amrapChangeNotifier.dart';

class AMRAPStepScreen extends StatelessWidget {
  final AMRAPStepInstance step;
  final Function nextStep;

  AMRAPChangeNotifier _notifier;
  CountDownController _controller;

  AMRAPStepScreen({@required this.step, @required this.nextStep}) {
    _notifier = AMRAPChangeNotifier(step: step);
    _controller = CountDownController();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AMRAPChangeNotifier>.value(
      value: _notifier,
      builder: (_, __) => Consumer<AMRAPChangeNotifier>(
        builder: (ctx, notifier, __) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  height: 385,
                  width: 385,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(3, 5),
                            blurRadius: 9,
                            color: CustomColors.darkGrey)
                      ]),
                ),
                SingleCircularSlider(
                  notifier.step.targetReps,
                  notifier.step.actualReps % notifier.step.targetReps,
                  shouldCountLaps: true,
                  onSelectionChange: (_, value, laps) =>
                      notifier.setReps(value + notifier.step.targetReps * laps),
                  height: 400,
                  width: 400,
                  selectionColor: CustomColors.blue,
                  baseColor: CustomColors.lightGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          '${notifier.completed() ? 'Rest' : notifier.step.actualReps}',
                          style: TextStyle(fontSize: 64)),
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Container(
                            height: 195,
                            width: 195,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(1, 3),
                                    blurRadius: 4,
                                    color: CustomColors.darkGrey)
                              ],
                            ),
                          ),
                          CircularCountDownTimer(
                            duration: 60,
                            height: 200,
                            width: 200,
                            strokeWidth: 10,
                            controller: _controller,
                            fillColor: notifier.started()
                                ? CustomColors.blue
                                : CustomColors.lightGrey,
                            color: CustomColors.lightGrey,
                            isTimerTextShown: false,
                            backgroundColor: CustomColors.white,
                            onComplete: () {
                              _controller.restart(duration: 60);
                            },
                          ),
                          Text(
                            notifier.getTimeElapsed(),
                            style: TextStyle(
                                fontSize: 32, color: CustomColors.grey),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () => getNextScreen(ctx),
              child: Text(
                getButtonText(ctx),
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getButtonText(BuildContext context) {
    AMRAPChangeNotifier notifier =
        Provider.of<AMRAPChangeNotifier>(context, listen: false);
    if (notifier.completed()) {
      return 'Next Step';
    } else if (notifier.started()) {
      return 'Finish';
    } else {
      return 'Start';
    }
  }

  void getNextScreen(BuildContext context) {
    AMRAPChangeNotifier notifier =
        Provider.of<AMRAPChangeNotifier>(context, listen: false);
    if (notifier.completed()) {
      nextStep();
    } else if (notifier.started()) {
      notifier.endTimer();
    } else {
      _controller.restart(duration: 60);
      notifier.startTimer();
    }
  }
}
