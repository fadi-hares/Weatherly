import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_icons/weather_icons.dart';

import '../models/custom_error.dart';
import '../models/weather.dart';
import '../repositories/weather_repositories.dart';

enum WeatherStatus {
  initial,
  loading,
  loaded,
  error,
}

class WeatherState extends Equatable {
  final WeatherStatus weatherStatus;
  final CustomError error;
  final Weather weather;
  final Position position;
  const WeatherState({
    required this.weatherStatus,
    required this.error,
    required this.weather,
    required this.position,
  });

  factory WeatherState.initial() {
    return WeatherState(
      position: Position(
        longitude: 0.0,
        latitude: 0.0,
        timestamp: DateTime.now(),
        accuracy: 0.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
      ),
      weatherStatus: WeatherStatus.initial,
      error: CustomError(error: ''),
      weather: Weather.initial(),
    );
  }

  @override
  List<Object> get props => [weatherStatus, error, weather];

  WeatherState copyWith({
    Position? position,
    WeatherStatus? weatherStatus,
    CustomError? error,
    Weather? weather,
  }) {
    return WeatherState(
      position: position ?? this.position,
      weatherStatus: weatherStatus ?? this.weatherStatus,
      error: error ?? this.error,
      weather: weather ?? this.weather,
    );
  }

  @override
  String toString() =>
      'WeatherState(weatherStatus: $weatherStatus, error: $error, weather: $weather, position: $position)';
}

class WeatherProvider extends ChangeNotifier {
  WeatherState _state = WeatherState.initial();
  WeatherState get state => _state;

  WeatherRepositories weatherRepositories;
  WeatherProvider({
    required this.weatherRepositories,
  });

  Future<void> fetchWeatherData() async {
    _state = _state.copyWith(weatherStatus: WeatherStatus.loading);
    notifyListeners();
    try {
      Position position = await weatherRepositories.getDeviceLocation();
      Weather weather = await weatherRepositories.featchTheWeather(position);
      _state = _state.copyWith(
        position: position,
        weather: weather,
        weatherStatus: WeatherStatus.loaded,
      );
      notifyListeners();
    } on CustomError catch (e) {
      _state = _state.copyWith(error: e, weatherStatus: WeatherStatus.error);
      notifyListeners();
    }
  }

  IconData getTheCorrectIcon(String icon) {
    if (icon == '11d') {
      return WeatherIcons.thunderstorm;
    } else if (icon == '09d') {
      return WeatherIcons.rain_mix;
    } else if (icon == '10d') {
      return WeatherIcons.day_rain;
    } else if (icon == '13d') {
      return WeatherIcons.snow;
    } else if (icon == '09d') {
      return WeatherIcons.rain;
    } else if (icon == '50d') {
      return WeatherIcons.fog;
    } else if (icon == '01d') {
      return WeatherIcons.day_sunny;
    } else if (icon == '01n') {
      return WeatherIcons.night_clear;
    } else if (icon == '02d') {
      return WeatherIcons.day_cloudy;
    } else if (icon == '02n') {
      return WeatherIcons.night_cloudy;
    } else if (icon == '03d') {
      return WeatherIcons.cloudy;
    } else if (icon == '03n') {
      return WeatherIcons.cloudy;
    } else if (icon == '04d') {
      return WeatherIcons.cloudy;
    } else {
      return WeatherIcons.cloudy;
    }
  }

  Color getTheCorrectIconColor(String icon) {
    if (icon == '11d') {
      return Colors.blueAccent;
    } else if (icon == '09d') {
      return Colors.blueAccent;
    } else if (icon == '10d') {
      return Colors.white;
    } else if (icon == '13d') {
      return Colors.blueAccent;
    } else if (icon == '09d') {
      return Colors.blueAccent;
    } else if (icon == '50d') {
      return Colors.white;
    } else if (icon == '01d') {
      return Colors.orange;
    } else if (icon == '01n') {
      return Colors.orange;
    } else if (icon == '02d') {
      return Colors.white;
    } else if (icon == '02n') {
      return Colors.white;
    } else if (icon == '03d') {
      return Colors.white;
    } else if (icon == '03n') {
      return Colors.white;
    } else if (icon == '04d') {
      return Colors.white;
    } else {
      return Colors.white;
    }
  }

  String getTheCorrectWeatherSVG(String icon) {
    if (icon == '11d') {
      return '11d.svg';
    } else if (icon == '09d') {
      return '09d.svg';
    } else if (icon == '10d') {
      return '10d.svg';
    } else if (icon == '13d') {
      return '13d.svg';
    } else if (icon == '09d') {
      return '09d.svg';
    } else if (icon == '50d') {
      return '50d.svg';
    } else if (icon == '01d') {
      return '01d.svg';
    } else if (icon == '01n') {
      return '01n.svg';
    } else if (icon == '02d') {
      return '02d.svg';
    } else if (icon == '02n') {
      return '02n.svg';
    } else if (icon == '03d') {
      return '03d-03n.svg';
    } else if (icon == '03n') {
      return '03d-03n.svg';
    } else if (icon == '04d') {
      return '04d-04n.svg';
    } else {
      return '04d-04n.svg';
    }
  }
}
