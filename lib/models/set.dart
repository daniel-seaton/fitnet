class Set {
  num goal;
  num actual;
  num weight;
  DateTime start;
  DateTime end;

  Set({this.goal, this.actual, this.weight});

  Set.fromMap(Map<String, dynamic> map) {
    goal = map['goal'];
    if (map['actual'] != null) actual = map['actual'];
    if (map['weight'] != null) weight = map['weight'];
    if (map['start'] != null)
      start = DateTime.fromMillisecondsSinceEpoch(map['start']);
    if (map['end'] != null)
      end = DateTime.fromMillisecondsSinceEpoch(map['end']);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'goal': goal,
    };

    if (weight != null) map['weight'] = weight;
    if (actual != null) map['actual'] = actual;
    if (start != null) map['start'] = start.millisecondsSinceEpoch;
    if (end != null) map['end'] = end.millisecondsSinceEpoch;
    return map;
  }

  bool isComplete() {
    return start != null && end != null;
  }

  bool isInProgress() {
    return start != null && end == null;
  }

  begin() {
    start = DateTime.now();
  }

  complete() {
    end = DateTime.now();
  }

  goalMet() {
    return actual >= goal;
  }

  double percentComplete() {
    if (end == null) {
      return 0;
    }
    return ((actual / goal) * 1000).round() / 10;
  }
}
