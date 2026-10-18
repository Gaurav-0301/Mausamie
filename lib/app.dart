import 'package:flutter/material.dart';
import 'package:mausamie/screens/WeatherScreen.dart';

class MausamieApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mausamie",
     theme: ThemeData(
      primarySwatch: Colors.lightBlue,
      fontFamily: 'Arial',
      textTheme: TextTheme(
        bodyLarge: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
      )
     ),
     home:WeatherScreen(),
     debugShowCheckedModeBanner: false,
    );
  }
}
