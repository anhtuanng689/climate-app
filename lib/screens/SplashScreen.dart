import 'package:climate_app/utils/SizeConfig.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFF2e2e2e),
      body: Center(
        child: Image.asset(
          'assets/climate-splash.png',
          scale: 1.5,
        ),
      ),
    );
  }
}
