library github_calendar;
import 'package:flutter/widgets.dart';

///
class GithubCalendar extends StatelessWidget {
  GithubCalendar({Key key, this.color,this.degresses}) : super(key: key);
  final List<int> degresses;
  final Color color;
  static const months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    var days = now.weekday + 52 * 7;
    var dr = Duration(days: days);
    var yy = now.subtract(dr);
    var lastM = yy.month;
    var listM = [];
    var lastP = 0;
    for (var i = 0; i < 52; i++) {
      var cM = yy.add(Duration(days: 7 * i)).month;
      if (cM != lastM) {
        listM.add(i - lastP);
        lastP = i;
        lastM = cM;
      }
    }
    if (listM.length < 13) listM.add(2);
    return Row(
      children: <Widget>[
        Container(
          width: 25,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(
                "Sun",
                style: TextStyle(fontSize: 10),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Thr",
                style: TextStyle(fontSize: 10),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Sat",
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Row(
                children: List.generate(listM.length, (index) {
                  var m = ((now.month + index - 1) % 12);
                  int width = listM[index] * 10;
                  return Container(
                    alignment: Alignment.centerLeft,
                    height: 15,
                    width: width.toDouble(),
                    child: Text(months[m], style: TextStyle(fontSize: 10)),
                  );
                }),
              ),
              Container(
                height: 70,
                child: SquareWall(
                  color: color,
                  days: days,
                  deeps: degresses,
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
            var curColor = (index >= deeps.length|| deeps[index] == 0)
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
