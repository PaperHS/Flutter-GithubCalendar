library github_calendar;
import 'dart:math';

import 'package:flutter/widgets.dart';

/// 
class GithubCalendar extends StatefulWidget {

  GithubCalendar({Key key}) : super(key: key);

  _GithubCalendarState createState() => _GithubCalendarState();
}

class _GithubCalendarState extends State<GithubCalendar> {

  int days = 365;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
       child: GridView.count(
         scrollDirection: Axis.horizontal,
         crossAxisCount: 7,
          children: List.generate(days, (index){
          return Container(
            width: 1,
            height: 1,
            decoration: BoxDecoration(color: Color.fromARGB(Random().nextInt(255), 34, 112, 222)),
            child: SizedBox(height: 1,width: 1,),
          );
        })),
       );
  }
}
