import 'package:flutter/material.dart';
import 'package:weather_app/consts/consts.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/models/card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<Weather>? weather;
  String city = "Çankaya Ankara";

  List<CardWidget> card = [];

  TextEditingController cityController = TextEditingController();

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

  void createList(int hour, AsyncSnapshot<Weather> snapshot) {
    card.clear();
    for (int i = hour; i < 24; i++) {
      CardWidget widget = CardWidget(
        icon: snapshot.data!.weatherIcon,
        temp: snapshot.data!.temp,
        time: i,
      );
      card.add(widget);
    }
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
        floatingActionButton: FloatingActionButton(
          tooltip: 'Search Weather',
          onPressed: () => _showDialog(context),
          child: const Icon(Icons.search),
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
                        createList(DateTime.parse(snapshot.data!.dateTime).hour,
                            snapshot);
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Text(
                              snapshot.data!.name,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: size - 5, color: textColor),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: card.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CardWidget(
                                        icon: card[index].icon,
                                        temp: card[index].temp,
                                        time: card[index].time,
                                      );
                                    },
                                  ),
                                ))
                              ],
                            )
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

  Future<void> _showDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Search Weather of City'),
          content: TextFormField(
            controller: cityController,
            decoration: const InputDecoration(
              hintText: "Enter a City",
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color.fromARGB(255, 243, 56, 43)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(
                'Search',
                style: TextStyle(color: appBarbgColor),
              ),
              onPressed: () {
                getWeather(cityController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
