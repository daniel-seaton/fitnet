class Set {
  num goal;
  num actual;
  num weight;
  DateTime start;
  DateTime end;

  Set.fromMap(Map<String, dynamic> map) {
    goal = map['goal'];
    actual = map['actual'];
    weight = map['weight'];
    if (map['start'])
      start = DateTime.fromMillisecondsSinceEpoch(map['start'].seconds * 1000);
    if (map['end'])
      start = DateTime.fromMillisecondsSinceEpoch(map['end'].seconds * 1000);
  }
}
