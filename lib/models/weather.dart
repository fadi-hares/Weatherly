// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  String timeZone;
  String icon;
  String situation;
  double temprature;
  double windSpeed;
  int humidity;
  List<dynamic> hourly;
  List<dynamic> daily;
  Map<String, dynamic>? alerts;

  Weather({
    required this.timeZone,
    required this.icon,
    required this.situation,
    required this.temprature,
    required this.windSpeed,
    required this.humidity,
    required this.hourly,
    required this.daily,
    required this.alerts,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic>? validAlerts;
    if (json['alerts'] != null) {
      validAlerts = json['alerts'][0];
    }
    return Weather(
      timeZone: json['timezone'],
      icon: json['current']['weather'][0]['icon'],
      situation: json['current']['weather'][0]['main'],
      temprature: json['current']['temp'],
      windSpeed: json['current']['wind_speed'],
      humidity: json['current']['humidity'],
      hourly: json['hourly'],
      daily: json['daily'],
      alerts: validAlerts,
    );
  }

  factory Weather.initial() {
    return Weather(
      timeZone: '',
      humidity: 0,
      icon: '',
      situation: '',
      temprature: 0.0,
      windSpeed: 0.0,
      daily: const [],
      hourly: const [],
      alerts: const {},
    );
  }

  @override
  List<Object> get props {
    return [
      timeZone,
      icon,
      situation,
      temprature,
      windSpeed,
      humidity,
      hourly,
      daily,
      alerts!,
    ];
  }

  @override
  String toString() {
    return 'Weather(timeZone: $timeZone, icon: $icon, situation: $situation, temprature: $temprature, windSpeed: $windSpeed, humidity: $humidity, hourly: $hourly, daily: $daily, alerts: $alerts)';
  }
}
