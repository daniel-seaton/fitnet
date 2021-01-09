import 'package:fitnet/models/workoutStepInstance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../SetsChangeNotifier.dart';
import 'currentSetDisplay/currentSetDisplay.dart';
import 'setsDisplayRow/setsDisplayRow.dart';

class SetBasedStepScreen extends StatelessWidget {
  final SetBasedStepInstance step;
  final Function nextStep;

  SetsChangeNotifier _notifier;

  SetBasedStepScreen({@required this.step, @required this.nextStep}) {
    _notifier = SetsChangeNotifier(sets: step.sets);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SetsChangeNotifier>.value(
      value: _notifier,
      builder: (_, __) => Column(
        children: [
          Expanded(flex: 5, child: SetsDisplayRow()),
          Expanded(flex: 16, child: CurrentSetDisplay()),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<SetsChangeNotifier>(
                  builder: (ctx, notifier, __) => ElevatedButton(
                    onPressed: () => getNextScreen(ctx),
                    child: Text(
                      getButtonText(ctx),
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String getButtonText(BuildContext context) {
    SetsChangeNotifier setsNotifier =
        Provider.of<SetsChangeNotifier>(context, listen: false);
    if (setsNotifier.currentSet.isInProgress()) {
      return setsNotifier.currentIndex == setsNotifier.sets.length - 1
          ? 'Finish Step'
          : 'Finish Set';
    } else {
      return 'Start Set';
    }
  }

  void getNextScreen(BuildContext context) {
    SetsChangeNotifier setsNotifier =
        Provider.of<SetsChangeNotifier>(context, listen: false);
    if (setsNotifier.currentSet.isInProgress()) {
      setsNotifier.finishCurrentSet();
      if (setsNotifier.currentIndex == setsNotifier.sets.length) nextStep();
    } else {
      setsNotifier.startNextSet();
    }
  }
}
