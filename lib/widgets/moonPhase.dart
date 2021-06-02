import 'package:flutter/material.dart';
import 'package:flutter_weather/helper/utils.dart';
import 'package:flutter_weather/helper/utils.dart';
import 'package:flutter_weather/screens/moonPhaseCalendar.dart';
import 'package:intl/intl.dart';

class MoonPhase extends StatelessWidget {
  final wData;

  MoonPhase({this.wData});

  final TextStyle _style1 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  final TextStyle _style2 = TextStyle(
    fontWeight: FontWeight.w400,
    color: Colors.grey[700],
    fontSize: 14,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Row(
            children: [
              Text(
                'Moon Phase',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, MoonPhaseCalendar.routeName);
                },
                child: Text(
                  'See more',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4dabd5)),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 0,
                blurRadius: 15,
                offset: Offset(6, 8),
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.2,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, MoonPhaseCalendar.routeName);
            },
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Text(
                        'Today',
                        style: _style2,
                      ),
                      Spacer(),
                      Image.asset(
                        'assets/${MoonString.getMoonImage(wData.moon.age)}.png',
                        scale: 0.85,
                      ),
                      Spacer(),
                      Text(
                        '${MoonString.getMoonPhase(wData.moon.age)}',
                        style: _style1,
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Text(
                        '${DateFormat.MMMMd().format(DateTime.fromMillisecondsSinceEpoch(MoonString.getNextMoonPhase(wData.moon.age, wData.dateTime).values.toList()[0] * 1000))}',
                        style: _style2,
                      ),
                      Spacer(),
                      Image.asset(
                        'assets/${MoonString.getMoonImage(MoonString.getNextMoonPhase(wData.moon.age, wData.dateTime).keys.toList()[0])}.png',
                        scale: 0.85,
                      ),
                      Spacer(),
                      Text(
                        '${MoonString.getMoonPhase(MoonString.getNextMoonPhase(wData.moon.age, wData.dateTime).keys.toList()[0])}',
                        style: _style1,
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Text(
                        '${DateFormat.MMMMd().format(DateTime.fromMillisecondsSinceEpoch(MoonString.getNextMoonPhase(wData.moon.age, wData.dateTime).values.toList()[1] * 1000))}',
                        style: _style2,
                      ),
                      Spacer(),
                      Image.asset(
                        'assets/${MoonString.getMoonImage(MoonString.getNextMoonPhase(wData.moon.age, wData.dateTime).keys.toList()[1])}.png',
                        scale: 0.85,
                      ),
                      Spacer(),
                      Text(
                        '${MoonString.getMoonPhase(MoonString.getNextMoonPhase(wData.moon.age, wData.dateTime).keys.toList()[1])}',
                        style: _style1,
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
