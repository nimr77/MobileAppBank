import 'package:flutter/material.dart';

class MyValidators {
  ///this will remove the dot from the string
  static String RemoveDot(String Text) {
    String R1 = Text.toUpperCase();
    String R = "";
    for (int i = 0; i < R1.length; i++) {
      if (String.fromCharCode(R1.codeUnitAt(i)) != ".") {
        R += String.fromCharCode(R1.codeUnitAt(i));
      }
    }
    return R;
  }

  static String removeAllLettersFromString(String input) {
    String R1 = input.toUpperCase();
    String R = "";
    for (int i = 0; i < R1.length; i++) {
      if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
          .hasMatch(String.fromCharCode(R1.codeUnitAt(i)))) {
        R += String.fromCharCode(R1.codeUnitAt(i));
      }
    }
    return R;
  }

  ///This will check if the types contains any increment value
  static bool containsIncrementValue(List<Map> myType) {
    for (var t in myType) {
      if (t["Prix"] != null &&
          t["Prix"] < 35 &&
          t["Nom"] != "Séchage seul" &&
          t["Nom"] != "Livraison") {
        return true;
      }
    }
    return false;
  }

  static String loadNumber(String value) {
    try {
      return value.toString().split('.')[0] +
          '.' +
          value.toString().split('.')[1].substring(0, 1);
    } catch (e) {
      return value.toString();
    }
  }

  ///This will get the duration interval from a starting time to the end time
  static List<Duration> getInterval({
    int startTime = 0,
    int forEachWhat,
    int totalMin = Duration.millisecondsPerDay,
  }) {
    final r = List<Duration>();
    forEachWhat = forEachWhat ?? Duration(minutes: 30).inMilliseconds;
    totalMin += startTime;
    for (int i = startTime; i <= totalMin; i += forEachWhat)
      r.add(Duration(milliseconds: i));
    return r;
  }

  static String showGoodTime(DateTime time) =>
      '${time.year}-${time.month}-${time.day} ${showTime(time)}';
  static String showTime(DateTime time) =>
      '${time.hour}:${time.minute > 9 ? time.minute : "0" + time.minute.toString()}';
  static String showTheBestTimeViewWithDate(DateTime date) {
    try {
      return DateTime.now().difference(date).inDays == 0
          ? showTime(date)
          : DateTime.now().difference(date).inDays > 0
              ? showGoodTime(date)
              : "0:00";
    } catch (e) {
      return "0:00";
    }
  }

  static String showTheBestTimeViewWithDateFuture(DateTime date) {
    try {
      return date.difference(DateTime.now()).inDays == 0
          ? showTime(date)
          : date.difference(DateTime.now()).inDays > 0
              ? showGoodTime(date)
              : "0:00";
    } catch (e) {
      return "0:00";
    }
  }

  static String printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  static bool getIfSameDate(DateTime timeOne, DateTime timeTwo) {
    return timeOne.year == timeTwo.year &&
        timeOne.month == timeTwo.month &&
        timeOne.day == timeTwo.day;
  }

  static double toDouble(TimeOfDay myTime) =>
      myTime.hour + myTime.minute / 60.0;

  static pagination(List list, int size, [int pageNumber = 1]) {}
  static dynamic myEncode(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }

  static String viewOnlyCrDate(DateTime dateTime) =>
      "${dateTime.year}/${dateTime.month}";
}
