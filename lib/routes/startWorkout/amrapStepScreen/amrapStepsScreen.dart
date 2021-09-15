import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:fitnet/models/workoutStepInstance.dart';
import 'package:fitnet/shared/notifiers/amrapChangeNotifier.dart';
import 'package:fitnet/shared/notifiers/instanceChangeNotifier.dart';
import 'package:fitnet/utils/customColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';
import 'package:provider/provider.dart';

import '../../../shared/mixins/timerControlMixin.dart';

class AMRAPStepScreen extends StatelessWidget {

  CountDownController _controller;

  AMRAPStepScreen() {
    _controller = CountDownController();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<InstanceChangeNotifier, AMRAPChangeNotifer>(
      create: (ctx) => AMRAPChangeNotifer(parent: Provider.of<InstanceChangeNotifier>(ctx, listen: false)),
      update: (_, instance, notifier) {
        notifier.setParent(instance);
        return notifier;
      },
      builder: (ctx, __) => Column(
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
              Consumer<AMRAPChangeNotifer>(
                builder: (_, notifier, __) => SingleCircularSlider(
                  notifier.currentStep.targetReps,
                  notifier.currentStep.actualReps % notifier.currentStep.targetReps,
                  shouldCountLaps: true,
                  onSelectionChange: (_, value, laps) =>
                      notifier.setReps(value + notifier.currentStep.targetReps * laps),
                  height: 400,
                  width: 400,
                  selectionColor: CustomColors.blue,
                  baseColor: CustomColors.lightGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${!notifier.started() || notifier.completed() ? 'Rest' : notifier.currentStep.actualReps}',
                        style: TextStyle(fontSize: 64),
                      ),
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
    );
  }

  String getButtonText(BuildContext context) {
    AMRAPChangeNotifer notifier =
        Provider.of<AMRAPChangeNotifer>(context, listen: false);
    if (notifier.completed()) {
      return 'Next Step';
    } else if (notifier.started()) {
      return 'Finish';
    } else {
      return 'Start';
    }
  }

  void getNextScreen(BuildContext context) {
    AMRAPChangeNotifer notifier =
        Provider.of<AMRAPChangeNotifer>(context, listen: false);
    if (!notifier.currentStep.isStarted) notifier.startStep();
    else if (!notifier.currentStep.isCompleted) notifier.completeStep();
    else {
      _controller.restart(duration: 60);
      notifier.start();
    }
  }
}
