import 'dart:convert';

import 'package:http/http.dart' as http;

class Weather {
  final double temp;
  final String weatherIcon;
  final String weatherTitle;

  static const String apiKey = "b4f34e5fd92c4883bc575621240905";

  Weather({
    required this.temp,
    required this.weatherIcon,
    required this.weatherTitle,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temp: json['current']['temp_c'],
      weatherIcon: json['current']['condition']['icon'],
      weatherTitle: json['current']['condition']['text'],
    );
  }
}

Future<Weather> fetchWeather(String city) async {
  final response = await http.get(Uri.parse(
      'http://api.weatherapi.com/v1/current.json?key=${Weather.apiKey}&q=$city&aqi=no'));

  if (response.statusCode == 200) {
    Map<String, dynamic> json =
        jsonDecode(response.body) as Map<String, dynamic>;
    return Weather.fromJson(json);
  } else {
    throw Exception('Failed to load weather');
  }
}
