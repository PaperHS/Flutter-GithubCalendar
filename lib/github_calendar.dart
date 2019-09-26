library github_calendar;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///
class GithubCalendar extends StatefulWidget {
  GithubCalendar({Key key}) : super(key: key);

  _GithubCalendarState createState() => _GithubCalendarState();
}

class _GithubCalendarState extends State<GithubCalendar> {
  static const months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
  static const bigMonth = [1,3,5,7,8,10,12];
  static const littleMonth = [4, 6, 9, 11];

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    now.weekday;

    var days = now.weekday + 365;
    var list = List.generate(days, (index) {
      return Random().nextInt(5);
    });
    var dr = Duration(days: days);
    var yy = now.subtract(dr);
    var intervals = [];
    int last = 0;
    for (var x = 1; x < 13; x++) {
      var nextMonth = DateTime(yy.year, yy.month+x, 1);
      var interval = nextMonth.difference(yy).inDays~/7;
    
      print("interval:${interval -last}");
      intervals.add(interval-last);
      last = interval;
    }
    return Row(
      children: <Widget>[
        Container(
          width: 25,
          child: Column(
            children: <Widget>[
              SizedBox(height: 10,),
              Text("Sun",style: TextStyle(fontSize: 10),),
              SizedBox(height: 20,),
              Text("Thr",style: TextStyle(fontSize: 10),),
              SizedBox(height: 16,),
              Text("Sat",style: TextStyle(fontSize: 10),),
              ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Row(
                children: List.generate(12, (index){  
                  var m = ((now.month+index)%12);
                  return Container(
                    alignment: Alignment.centerRight,
                    width: intervals[index]*10,
                    child: Text(months[m] ,style: TextStyle(fontSize: 10)),
                  );
                }),
              ),
              Container(
                height: 70,
                child: SquareWall(
                  color: Color(3065343),
                  days: days,
                  deeps: list,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SquareWall extends StatelessWidget {
  SquareWall({Key key, this.days, this.color, this.deeps}) : super(key: key);
  final int days;
  final Color color;
  final List<int> deeps;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: GridView.count(
          scrollDirection: Axis.horizontal,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          crossAxisCount: 7,
          children: List.generate(days, (index) {
            var curColor = deeps[index] == 0
                ? Color.fromARGB(255, 235, 237, 240)
                : Color.fromARGB(
                    deeps[index] * 51, color.red, color.green, color.blue);
            return Container(
              width: 9,
              height: 9,
              decoration: BoxDecoration(color: curColor),
              child: SizedBox(
                height: 1,
                width: 1,
              ),
            );
          })),
    );
  }
}
