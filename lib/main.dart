import 'package:flutter/material.dart';
import 'package:just_parking/view/splashscreen.dart';

void main()  {
 

  runApp(JustParkingApp());
}

class JustParkingApp extends StatelessWidget {
  static final TextStyle appText = TextStyle(color: Colors.blue);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white, accentColor: Colors.blue),
      title: "UCO Just Parking",
      home: SplashScreen(),
    );
  }
}
