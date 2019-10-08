library github_calendar;

import 'dart:math';

import 'package:flutter/widgets.dart';

/// Creates a Calendar heatmap
/// The total height is 70 (calendar) + 15
class GithubCalendar extends StatelessWidget {
  const GithubCalendar({
    Key key,
    @required this.color,
    @required this.data,
    this.initialColor = const Color.fromARGB(255, 235, 237, 240),
    this.boxSize = 9,
    this.boxPadding = 2,
    // this.width,
    this.height = 70,
    this.style = const TextStyle(),
  })  : assert(color != null),
        assert(initialColor != null),
        assert(data != null),
        super(key: key);

  /// The second [Color] containing a max density
  final Color color;

  /// The density (displayed via color) in each box
  final List<int> data;

  /// The initial `cold` value, or the [Color] of a box without density
  final Color initialColor;

  final double boxPadding;

  final double boxSize;

  final double height;
  // final double width;
  final TextStyle style;

  final _monthsHeight = 15.0;

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
    'Dec',
  ];

  @override
  Widget build(BuildContext context) {
    final boxSizeAndPadding = boxSize + boxPadding;
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
        style: style,
        child: Row(
          children: <Widget>[
            Container(
              width: 25,
              child: Column(
                children: <Widget>[
                  SizedBox(height: _monthsHeight),
                  SizedBox(
                    height: boxSizeAndPadding,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text('Sun'),
                    ),
                  ),
                  SizedBox(height: boxSizeAndPadding * 2),
                  SizedBox(
                    height: boxSizeAndPadding,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text('Thr'),
                    ),
                  ),
                  SizedBox(height: boxSizeAndPadding * 2),
                  SizedBox(
                    height: boxSizeAndPadding,
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text('Sat'),
                    ),
                  ),
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
                          height: _monthsHeight,
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
                      boxSize: boxSize,
                      days: days,
                      data: data,
                      max: data.reduce(max),
                      boxPadding: boxPadding,
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
    @required this.boxSize,
    @required this.boxPadding,
    @required this.color,
    @required this.data,
    @required this.max,
  })  : assert(days != null),
        assert(color != null),
        assert(initialColor != null),
        assert(boxSize != null),
        assert(boxPadding != null),
        assert(data != null),
        assert(max != null),
        super(key: key);

  final int days;
  final Color initialColor;
  final double boxSize;
  final double boxPadding;
  final Color color;
  final List<int> data;
  final int max;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      scrollDirection: Axis.horizontal,
      crossAxisSpacing: boxPadding,
      mainAxisSpacing: boxPadding,
      crossAxisCount: 7,
      children: List.generate(
        days,
        (index) {
          final curColor = index >= data.length
              ? initialColor
              : Color.lerp(initialColor, color, data[index] / max);

          return Container(
            width: boxSize,
            height: boxSize,
            color: curColor,
          );
        },
      ),
    );
  }
}
