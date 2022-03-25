import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';

class WeatherInfo extends StatelessWidget {
  String condition;
  dynamic temp;
  double windSpeed;
  int humidity;

  WeatherInfo({
    required this.condition,
    required this.humidity,
    required this.temp,
    required this.windSpeed,
  });

  @override
  Widget build(BuildContext context) {
    Color secondaryColor = Theme.of(context).colorScheme.secondary;
    return Column(
      children: [
        Text(
          condition,
          style: TextStyle(
            color: secondaryColor,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        GlowText(
          '${temp.toInt()}°',
          style: TextStyle(
            color: secondaryColor,
            fontSize: 70,
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
            SizedBox(
              width: 10,
            ),
            Text(
              // convert wind speed from m/sec to km/h
              '${(windSpeed * 3.6).toInt()} km/h',
              style: TextStyle(
                fontSize: 12,
                color: secondaryColor,
              ),
            ),
            SizedBox(width: 10),
            Icon(
              CupertinoIcons.drop,
              size: 20,
              color: secondaryColor,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              '${humidity.toInt()}%',
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
