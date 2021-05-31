import 'package:intl/intl.dart';

class Chart {
  final String time;
  final int percent;

  Chart({this.time, this.percent});

  factory Chart.fromMap(Map<String, dynamic> json) => Chart(
        time: DateFormat.j()
            .format(DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000)),
        // time: json['dt'].toString(),
        percent: (((json['pop'] * 100 / 10).round()) * 10),
      );

  // static Chart fromPreJson(dynamic json) {
  //   return Chart(
  //     time: DateFormat.jm()
  //         .format(DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000)),
  //     percent: (((json['pop'] * 100 / 10).round()) * 10),
  //   );
  // }
}
