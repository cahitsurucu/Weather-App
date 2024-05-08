import 'package:flutter/material.dart';
import 'package:weather_app/consts/consts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarbgColor,
          title: const Text("Weather App"),
        ),
      ),
    );
  }
}
