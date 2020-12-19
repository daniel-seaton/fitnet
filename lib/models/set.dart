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
      start = DateTime.fromMillisecondsSinceEpoch(map['start'].seconds * 1000);
    if (map['end'] != null)
      start = DateTime.fromMillisecondsSinceEpoch(map['end'].seconds * 1000);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'goal': goal,
    };

    if (weight != null) map['weight'] = weight;
    if (actual != null) map['actual'] = actual;
    if (start != null) map['start'] = start;
    if (end != null) map['end'] = end;
    return map;
  }

  isComplete() {
    return start != null && end != null;
  }

  isInProgress() {
    return start != null && end == null;
  }

  goalMet() {
    return actual >= goal;
  }
}
