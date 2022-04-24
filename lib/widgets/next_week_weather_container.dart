import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../const/const.dart';
import '../providers/weather_provider.dart';

class NextWeekWeatherContainer extends StatelessWidget {
  final int date;
  final dynamic minTemp;
  final dynamic maxTemp;
  final String iconId;

  const NextWeekWeatherContainer({
    Key? key,
    required this.date,
    required this.iconId,
    required this.maxTemp,
    required this.minTemp,
  }) : super(key: key);

  // convert date from Unix timestamp to human readble date
  String convertDate() {
    var newDate = DateTime.fromMillisecondsSinceEpoch(date * 1000);
    var formattedDate = DateFormat('EEEE').format(newDate);
    return formattedDate.toString();
  }

  @override
  Widget build(BuildContext context) {
    final iconData =
        Provider.of<WeatherProvider>(context).getTheCorrectIcon(iconId);
    final iconColor =
        Provider.of<WeatherProvider>(context).getTheCorrectIconColor(iconId);
    return Container(
      padding: const EdgeInsets.only(right: 15),
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            child: Text(
              convertDate(),
              style: kDetailScreenTxtStyle,
            ),
          ),
          Row(
            children: [
              Text(
                '${maxTemp.toInt()}°',
                style: kDetailScreenTxtStyle,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '${minTemp.toInt()}°',
                style: kDetailScreenTxtStyle.copyWith(
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
          Icon(
            iconData,
            color: iconColor,
          ),
        ],
      ),
    );
  }
}
