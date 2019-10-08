library github_calendar;

import 'package:flutter/widgets.dart';

/// Creates a Calendar heatmap
class CustomGithubCalendar extends StatelessWidget {
  const CustomGithubCalendar({
    Key key,
    @required this.color,
    @required this.degresses,
    this.initialColor = const Color.fromARGB(255, 235, 237, 240),
    // this.width,
    this.height = 70,
    this.style = const TextStyle(),
  })  : assert(color != null),
        assert(initialColor != null),
        assert(degresses != null),
        super(key: key);

  /// The second [Color] containing a max density
  final Color color;

  /// The density (displayed via color) in each box from `0-1`
  final List<double> degresses;

  /// The initial `cold` value, or the [Color] of a box without density
  final Color initialColor;

  final double height;
  // final double width;
  final TextStyle style;

  final _months = const [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final days = now.weekday + 52 * 7;
    final dr = Duration(days: days);
    final yy = now.subtract(dr);
    final listM = <int>[];

    var lastM = yy.month;
    var lastP = 0;

    for (var i = 0; i < 52; i++) {
      final cM = yy.add(Duration(days: 7 * i)).month;

      if (cM != lastM) {
        listM.add(i - lastP);
        lastP = i;
        lastM = cM;
      }
    }

    if (listM.length < 13) listM.add(2);

    return Semantics(
      container: true,
      button: false,
      readOnly: true,
      label: 'Activity heat map',
      child: DefaultTextStyle(
        style: style.copyWith(fontSize: 10),
        child: Row(
          children: <Widget>[
            Container(
              width: 25,
              child: Column(
                children: const <Widget>[
                  SizedBox(height: 10),
                  Text('Sun'),
                  SizedBox(height: 20),
                  Text('Thr'),
                  SizedBox(height: 16),
                  Text('Sat'),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    children: List.generate(
                      listM.length,
                      (index) {
                        final m = ((now.month + index - 1) % 12);

                        final int width = listM[index] * 10;

                        return Container(
                          alignment: Alignment.centerLeft,
                          height: 15,
                          width: width.toDouble(),
                          child: Text(_months[m]),
                        );
                      },
                    ),
                  ),
                  Container(
                    height: height,
                    child: SquareWall(
                      color: color,
                      initialColor: initialColor,
                      days: days,
                      degresses: degresses,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SquareWall extends StatelessWidget {
  const SquareWall({
    Key key,
    @required this.days,
    @required this.initialColor,
    @required this.color,
    @required this.degresses,
  })  : assert(days != null),
        assert(color != null),
        assert(degresses != null),
        super(key: key);

  final int days;
  final Color initialColor;
  final Color color;
  final List<double> degresses;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      scrollDirection: Axis.horizontal,
      crossAxisSpacing: 1,
      mainAxisSpacing: 1,
      crossAxisCount: 7,
      children: List.generate(
        days,
        (index) {
          final curColor = (index >= degresses.length || degresses[index] == 0)
              ? initialColor
              : Color.lerp(initialColor, color, degresses[index]);

          return Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(color: curColor),
            child: const SizedBox(
              height: 1,
              width: 1,
            ),
          );
        },
      ),
    );
  }
}
