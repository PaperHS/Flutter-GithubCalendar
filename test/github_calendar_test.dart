import 'package:flutter_test/flutter_test.dart';

import 'package:github_calendar/github_calendar.dart';

void main() {
  test('adds one to input values', () {
   
  });

  test('time util', () {
    DateTime now = DateTime.now() ;
    print("WeekDay:${now.weekday}");
    print("day of month${now.day}");
    var days = now.weekday + 365;
    Duration d = Duration(days: days);
    var yy =now.subtract(d);
    print("last year:${yy.toIso8601String()}");
    print("last year:${yy.weekday}");

    for (var x = 1; x < 13; x++) {
    var nextMonth = DateTime(yy.year, yy.month+x, 1);
    var interval = nextMonth.difference(yy).inDays;
    print("interval:$interval");
         print("interval:${interval~/7}");
    }

  });
}
