import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:provider/provider.dart';

import '../models/weather.dart';
import '../providers/weather_provider.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Weather weather = context.read<WeatherProvider>().state.weather;
    Color secondaryColor = Theme.of(context).colorScheme.secondary;
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          weather.situation,
          style: TextStyle(
            color: secondaryColor,
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        GlowText(
          '${weather.temprature.toInt()}°',
          style: TextStyle(
            color: secondaryColor,
            fontSize: size.height * 0.09,
          ),
          blurRadius: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.wind,
              color: secondaryColor,
              size: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              // convert wind speed from m/sec to km/h
              '${(weather.windSpeed * 3.6).toInt()} km/h',
              style: TextStyle(
                fontSize: 12,
                color: secondaryColor,
              ),
            ),
            const SizedBox(width: 10),
            Icon(
              CupertinoIcons.drop,
              size: 20,
              color: secondaryColor,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              '${weather.humidity.toInt()}%',
              style: TextStyle(
                fontSize: 12,
                color: secondaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
