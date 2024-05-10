import 'dart:convert';

import 'package:http/http.dart' as http;

class Weather {
  final double temp;
  final String weatherIcon;
  final String weatherTitle;
  final double maxTemp;
  final double minTemp;

  static const String apiKey = "b4f34e5fd92c4883bc575621240905";

  Weather({
    required this.temp,
    required this.weatherIcon,
    required this.weatherTitle,
    required this.maxTemp,
    required this.minTemp,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temp: json['current']['temp_c'],
      weatherIcon: json['current']['condition']['icon'],
      weatherTitle: json['current']['condition']['text'],
      maxTemp: json['forecast']['forecastday'][0]['day']['maxtemp_c'],
      minTemp: json['forecast']['forecastday'][0]['day']['mintemp_c'],
    );
  }
}

Future<Weather> fetchWeather(String city) async {
  final response = await http.get(Uri.parse(
      'http://api.weatherapi.com/v1/forecast.json?key=${Weather.apiKey}&q=$city&days=1&aqi=no&alerts=no'));

  if (response.statusCode == 200) {
    Map<String, dynamic> json =
        jsonDecode(response.body) as Map<String, dynamic>;
    return Weather.fromJson(json);
  } else {
    throw Exception('Failed to load weather');
  }
}
