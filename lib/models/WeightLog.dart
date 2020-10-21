class WeightLog {
  DateTime dateLogged;
  int weight;

  WeightLog(this.weight) {
    this.dateLogged = DateTime.now();
  }

  WeightLog.fromMap(Map<String, dynamic> map) {
    this.weight = map['weight'];
    this.dateLogged =
        DateTime.fromMillisecondsSinceEpoch(map['dateLogged'].seconds * 1000);
  }
}
