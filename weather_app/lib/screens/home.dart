import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    getWeather(city);
  }

  void getWeather(String city) {
    setState(() {
      weather = fetchWeather(city);
    });
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
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  'http:${snapshot.data!.weatherIcon}',
                                  scale: 0.8,
                                ),
                                const SizedBox(
                                  width: 40,
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
                                      "Min : ${snapshot.data!.minTemp}",
                                      style: TextStyle(color: textColor),
                                    ),
                                    Text(
                                      "Max : ${snapshot.data!.maxTemp}",
                                      style: TextStyle(color: textColor),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 50,
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
