import 'package:fitnet/models/set.dart';
import 'package:fitnet/models/workoutStepInstance.dart';
import 'package:fitnet/shared/notifiers/instanceChangeNotifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/notifiers/setsChangeNotifier.dart';
import 'currentSetDisplay/currentSetDisplay.dart';
import 'setsDisplayRow/setsDisplayRow.dart';
class Test {
  List<Set> sets = [];

  Set get currentSet => sets.firstWhere((set) => !set.isComplete());

  Test();
}
class SetBasedStepScreen extends StatelessWidget {
  SetBasedStepScreen();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<InstanceChangeNotifier, SetsChangeNotifier>(
      create: (ctx) => SetsChangeNotifier(parent: Provider.of<InstanceChangeNotifier>(ctx, listen: false)),
      update: (_, instance, notifier) {
        notifier.setParent(instance);
        return notifier;
      },
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
                      getButtonText(notifier),
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

  String getButtonText(SetsChangeNotifier setsNotifier) {
    if(setsNotifier.currentSet == null) {
      return 'Finish Step';
    }

    if (setsNotifier.currentSet.isInProgress()) {
      return 'Finish Set';
    }

    return 'Start Set';
  }

  void getNextScreen(BuildContext context) {
    SetsChangeNotifier sets =
        Provider.of<SetsChangeNotifier>(context, listen: false);
    if (sets.currentSet.isInProgress()) sets.completeSet();
    else sets.startSet();
  }
}
