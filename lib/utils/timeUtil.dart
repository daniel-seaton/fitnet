import 'package:intl/intl.dart';

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
    milliseconds += '${((elapsedTime.inMilliseconds % 1000) / 100).truncate()}';

    return '$minutes:$seconds.$milliseconds';
  }

  static getTimeBeforeNowString(DateTime before) {
    var now = DateTime.now();
    var diff = now.difference(before);
    if (diff.inDays == 0) {
      return DateFormat.jm().format(before);
    } else if (diff.inDays < 10) {
      return '${diff.inDays} days ago';
    } else {
      return DateFormat.yMd().format(before);
    }
  }
}
