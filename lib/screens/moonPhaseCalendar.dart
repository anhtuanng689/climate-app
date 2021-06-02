import 'package:flutter/material.dart';
import 'package:flutter_weather/helper/utils.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MoonPhaseCalendar extends StatefulWidget {
  static const routeName = '/moonPhaseScreen';

  @override
  _MoonPhaseCalendarState createState() => _MoonPhaseCalendarState();
}

class _MoonPhaseCalendarState extends State<MoonPhaseCalendar> {
  bool loading;

  Future<void> onLoading() async {
    loading = true;
    Future.delayed(Duration(seconds: 6)).then((value) {
      loading = false;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    onLoading();
  }

  @override
  Widget build(BuildContext context) {
    print(loading);
    setState(() {});
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(
            'Moon Phase Calendar',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: loading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              )
            : Container(
                height: mediaQuery.size.height,
                width: mediaQuery.size.width,
                padding: EdgeInsets.all(10),
                child: SfCalendar(
                  view: CalendarView.month,
                  monthViewSettings: MonthViewSettings(
                      showTrailingAndLeadingDates: false, dayFormat: 'EEE'),
                  monthCellBuilder:
                      (BuildContext buildContext, MonthCellDetails details) {
                    return Container(
                      child: Column(
                        children: [
                          Text(
                            details.date.day.toString(),
                          ),
                          Image.asset(
                            'assets/${MoonString.getMoonImage(MoonString.moonPhaseFormula(details.date.year, details.date.month, details.date.day))}.png',
                            scale: 0.85,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
