class FormatType {
  static const SetBased = 'SetBased';
  static const RepsForTime = 'RepsForTime';
  static const AMRAP = 'AMRAP';

  static List<String> getTypes() {
    return [SetBased, RepsForTime, AMRAP];
  }
}

class Format {
  String displayValue;
  String value;

  Format({this.displayValue, this.value});

  Format.forType(this.value) {
    switch (value) {
      case FormatType.SetBased:
        displayValue = 'Set Based';
        break;
      case FormatType.RepsForTime:
        displayValue = 'Reps for Time';
        break;
      case FormatType.AMRAP:
        displayValue = 'As Many Reps as Possible';
        break;
    }
  }
}
