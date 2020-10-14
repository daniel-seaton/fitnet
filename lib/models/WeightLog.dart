class WeightLog {
  DateTime dateLogged;
  int weight;

  WeightLog(this.weight) {
    this.dateLogged = DateTime.now();
  }
}
