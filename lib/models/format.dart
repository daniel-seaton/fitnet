enum FormatType { SetBased, RepsForTime, AMRAP }

class Format {
  String displayValue;
  FormatType value;

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
