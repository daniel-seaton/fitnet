import 'package:fitnet/models/format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../workStepChangeNotifier.dart';

class StepFormatField extends StatelessWidget {
  final bool isEdit;

  StepFormatField({@required this.isEdit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 6,
          child: Text('Format:',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyText1),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          width: MediaQuery.of(context).size.width / 1.8,
          child: Consumer<WorkoutStepChangeNotifier>(
            builder: (_, notifier, __) => DropdownButtonFormField(
                disabledHint: Text(
                    notifier.step.format != null
                        ? notifier.step.format.displayValue
                        : '',
                    style: Theme.of(context).textTheme.bodyText1),
                value: notifier.step.format != null
                    ? notifier.step.format.value
                    : null,
                items: FormatType.getTypes()
                    .map((type) => DropdownMenuItem(
                        child: Text(Format.forType(type).displayValue,
                            style: Theme.of(context).textTheme.bodyText1),
                        value: type))
                    .toList(),
                onChanged:
                    isEdit ? (value) => notifier.setFormat(value) : null),
          ),
        ),
      ],
    );
  }
}
