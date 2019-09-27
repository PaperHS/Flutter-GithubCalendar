import 'package:flutter_test/flutter_test.dart';

import 'package:github_calendar/github_calendar.dart';

void main() {
  test('adds one to input values', () {
   
  });

  test('time util', () {
    DateTime now = DateTime.now() ;
    print("WeekDay:${now.weekday}");
    print("day of month${now.day}");
    var days = now.weekday + 7*52;
    Duration d = Duration(days: days);
    var yy =now.subtract(d);
    print("last year:${yy.toIso8601String()}");
    print("last year:${yy.weekday}");
    var lastM = yy.month;
    var listM = [0];
    var lastP = 0;
    for (var i = 0; i < 52; i++) {
        var cM = yy.add(Duration(days: 7*i)).month;
        if(cM != lastM){
          listM.add(i-lastP);
          print("pos:${i-lastP}");
          lastP = i;
          lastM = cM;
          
        }
    }  


  });
}
