import 'package:flutter/material.dart';
import 'package:weather_app/consts/consts.dart';
import 'package:weather_app/services/weather_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<Weather>? weather;
  String city = "Çankaya Ankara";
  @override
  void initState() {
    super.initState();
    weather = fetchWeather(city);
  }

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
          child: weather == null
              ? const Text("Weather no found")
              : FutureBuilder(
                  future: weather,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 150,
                            ),
                            Text(
                              city,
                              style: TextStyle(fontSize: 30, color: textColor),
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  color: iconColor,
                                  snapshot.data!.weatherTitle.contains('cloudy')
                                      ? cloudy
                                      : rain,
                                  size: 60,
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  snapshot.data!.temp.toString(),
                                  style:
                                      TextStyle(fontSize: 30, color: textColor),
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
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            Text(
                              snapshot.data!.weatherTitle,
                              style: TextStyle(
                                  fontSize: size - 5, color: textColor),
                            ),
                          ],
                        );
                      } else {
                        return const Text("No Weather Found");
                      }
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
        ),
      ),
    );
  }
}
