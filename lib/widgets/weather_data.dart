// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/weather.dart';
import '../providers/weather_provider.dart';
import 'card_weather_data.dart';

class WeatherData extends StatelessWidget {
  var date = DateFormat('EEE, d MMM').format(DateTime.now());

  WeatherData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Weather weather = context.read<WeatherProvider>().state.weather;
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
      child: Column(
        children: [
          Text(
            'Today : $date',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: weather.hourly.length,
              itemBuilder: (context, index) {
                return CardWeatherData(
                  icon: weather.hourly[index]['weather'][0]['icon'],
                  date: weather.hourly[index]['dt'],
                  temp: weather.hourly[index]['temp'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
