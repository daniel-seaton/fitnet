import 'package:fitnet/models/workout.dart';
import 'package:fitnet/models/workoutStepInstance.dart';
import 'package:fitnet/services/workoutInstanceService.dart';
import 'package:uuid/uuid.dart';

import '../serviceInjector.dart';

class WorkoutInstance {
  String iid;
  String wid;
  String uid;
  DateTime start;
  DateTime end;
  List<WorkoutStepInstance> steps = [];
  WorkoutInstanceService service = injector<WorkoutInstanceService>();
  Uuid uuid = injector<Uuid>();
  

  WorkoutInstance.fromWorkout(Workout workout) {
    iid = uuid.v4();
    wid = workout.wid;
    uid = workout.uid;
    steps = workout.steps
        .map((step) =>
            WorkoutStepInstance.forStep(step.formatType, step))
        .toList();
    start = DateTime.now();
    service.addInstance(this);
  }

  WorkoutInstance.fromMap(Map<String, dynamic> map) {
    iid = map['iid'];
    wid = map['wid'];
    uid = map['uid'];
    if (map['start'] != null)
      start = DateTime.fromMillisecondsSinceEpoch(map['start']);
    if (map['end'] != null)
      end = DateTime.fromMillisecondsSinceEpoch(map['end']);
    if (map['steps'] != null) {
      List<WorkoutStepInstance> mappedSteps = [];
      map['steps'].forEach((step) => mappedSteps
          .add(WorkoutStepInstance.forMap(step['formatType'], step)));
      steps = mappedSteps;
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'iid': iid,
      'wid': wid,
      'uid': uid,
    };
    if (start != null) map['start'] = start.millisecondsSinceEpoch;
    if (end != null) map['end'] = end.millisecondsSinceEpoch;
    if (steps != null)
      map['steps'] = steps.map((step) => step.toMap()).toList();
    return map;
  }

  complete() {
    end = DateTime.now();
    steps.firstWhere((step) => !step.isCompleted, orElse: () => null)?.complete();
    _update();
  }

  updateStep(WorkoutStepInstance step, [num index]) {
    steps[index ?? currentStepIndex] = step;
    _update();
  }

  _update() {
    service.updateInstance(this);
  }

  bool get isStarted => this.start != null;

  bool get isCompleted => this.end != null;

  WorkoutStepInstance get currentStep => this.steps.firstWhere((step) => !step.isCompleted, orElse: () => null);

  int get currentStepIndex => this.steps.indexWhere((step) => !step.isCompleted);

  double get percentComplete {
    var percentage = 0.0;
    steps.forEach((step) => percentage += step.percentComplete);
    return (percentage / steps.length * 10).round() / 10;
  }
}
