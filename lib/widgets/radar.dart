import 'package:flutter/material.dart';
import 'package:flutter_weather/screens/radarScreen.dart';

class Radar extends StatelessWidget {
  final wData;

  Radar({this.wData});

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
                'Radar',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RadarScreen.routeName);
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
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  'https://play-lh.googleusercontent.com/RAjq7DaNuiWZsvxl4Vl4qNFHZsM9Mk4so_CEnCbESc_6EjidgOdUAtn1LoVafrKUdw=s180'),
            ),
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
          height: MediaQuery.of(context).size.height * 0.25,
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RadarScreen.routeName);
            },
          ),
        ),
      ],
    );
  }
}
