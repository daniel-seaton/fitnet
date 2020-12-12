import 'package:fitnet/models/format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'amrapStepFields/expectedRepsField.dart';
import 'amrapStepFields/timeField.dart';
import 'repsForTimeStepFields/targetRepsField.dart';
import 'repsForTimeStepFields/targetTimeFields.dart';
import 'setBasedStepFields/minimumRestField.dart';
import 'setBasedStepFields/setsAndRepsField.dart';
import 'setBasedStepFields/targetWeightField.dart';

class FormatFieldFactory {
  static List<Widget> getFields(String type, bool isEdit) {
    switch (type) {
      case FormatType.SetBased:
        return [
          SetsAndRepsField(isEdit: isEdit),
          TargetWeightField(isEdit: isEdit),
          MinimumRestField(isEdit: isEdit)
        ];
      case FormatType.RepsForTime:
        return [
          TargetRepsField(isEdit: isEdit),
          TargetTimeField(isEdit: isEdit)
        ];
      case FormatType.AMRAP:
        return [TimeField(isEdit: isEdit), ExpectedRepsField(isEdit: isEdit)];
      default:
        return [];
    }
  }
}
