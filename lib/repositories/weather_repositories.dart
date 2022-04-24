import 'package:geolocator/geolocator.dart';

import '../models/custom_error.dart';
import '../models/weather.dart';
import '../services/device_loaction_service.dart';
import '../services/weather_api_service.dart';

class WeatherRepositories {
  DeviceLocationService deviceLocationService;
  WeatherApiService weatherApiService;
  WeatherRepositories({
    required this.deviceLocationService,
    required this.weatherApiService,
  });

  Future<Position> getDeviceLocation() async {
    try {
      final Position position = await deviceLocationService.getDeviceLocation();
      return position;
    } on LocationServiceDisabledException catch (e) {
      throw CustomError(error: e.toString());
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }

  Future<Weather> featchTheWeather(Position position) async {
    try {
      final Weather weather = await weatherApiService.getWeather(position);
      return weather;
    } catch (e) {
      throw CustomError(error: e.toString());
    }
  }
}
