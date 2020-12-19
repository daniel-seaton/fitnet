class TimeUtil {
  TimeUtil._();

  static getElapsedTimeString(Duration elapsedTime) {
    var minutes = '';
    var seconds = '';
    var milliseconds = '';

    minutes += '${elapsedTime.inMinutes}';
    if (elapsedTime.inSeconds % 60 < 10) {
      seconds += '0';
    }
    seconds += '${elapsedTime.inSeconds % 60}';

    if (((elapsedTime.inMilliseconds % 1000) / 10).round() < 10) {
      milliseconds += '0';
    }
    milliseconds += '${((elapsedTime.inMilliseconds % 1000) / 10).round()}';

    return '$minutes:$seconds.$milliseconds';
  }
}
