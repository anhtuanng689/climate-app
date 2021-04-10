import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2e2e2e),
      body: Center(
        child: Icon(
          Icons.android,
          color: Colors.white,
          size: MediaQuery.of(context).size.width * 0.8,
        ),
      ),
    );
  }
}
