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
        body: Container(
          color: bgColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "City",
                  style: TextStyle(fontSize: 28, color: textColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      color: iconColor,
                      cloudy,
                      size: 60,
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Text(
                      "-1",
                      style: TextStyle(fontSize: 30, color: textColor),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Text(
                          "Min : " + "data",
                          style: TextStyle(color: textColor),
                        ),
                        Text(
                          "Max : " + "data",
                          style: TextStyle(color: textColor),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
