import 'package:flutter/material.dart';

class MXCTime {
  /// Will try to subtract dateTime from now, So if positive then not reached yet
  static int getMinutesDifferenceByDateTime(DateTime dataTime) {
    final now = DateTime.now();
    final nowTimeOfDay = TimeOfDay.fromDateTime(now);
    final timeOfDay = TimeOfDay.fromDateTime(dataTime);

    final nowMinutes = timeOfDayInMinutes(nowTimeOfDay);
    final timeOfDayMinutes = timeOfDayInMinutes(timeOfDay);

    final difference = timeOfDayMinutes - nowMinutes;
    return difference;
  }

  static int timeOfDayInMinutes(TimeOfDay time) {
    return time.hour * 60 + time.minute;
  }
}

extension DateTimeExtension on DateTime {
  int unix() {
    return millisecondsSinceEpoch ~/ 1000;
  }

  static DateTime fromUnix(int unixTimestamp) {
    return DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
  }

  static DateTime fromUnixBigInt(BigInt unixTimestamp) {
    return fromUnix(unixTimestamp.toInt());
  }
}
