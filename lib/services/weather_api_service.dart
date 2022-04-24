import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'http_error_handler.dart';

import '../const/secrets.dart';
import '../models/weather.dart';

class WeatherApiService {
  Future<Weather> getWeather(Position position) async {
    final Uri url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/onecall?lat=${position.latitude}&lon=${position.longitude}&exclude=minutely&units=metric&appid=$apiKey');

    try {
      http.Response response = await http.get(url);
      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }
      final decodedWeather = json.decode(response.body);

      return Weather.fromJson(decodedWeather);
    } catch (e) {
      rethrow;
    }
  }
}
