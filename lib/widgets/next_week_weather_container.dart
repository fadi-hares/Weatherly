import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather.dart';

import '../const/const.dart';

class NextWeekWeatherContainer extends StatelessWidget {
  final int date;
  final dynamic minTemp;
  final dynamic maxTemp;
  final String iconId;

  NextWeekWeatherContainer({
    required this.date,
    required this.iconId,
    required this.maxTemp,
    required this.minTemp,
  });

  // convert date from Unix timestamp to human readble date
  String convertDate() {
    var newDate = DateTime.fromMillisecondsSinceEpoch(date * 1000);
    var formattedDate = DateFormat('EEEE').format(newDate);
    return formattedDate.toString();
  }

  @override
  Widget build(BuildContext context) {
    final iconData = Provider.of<Weather>(context).getTheCorrectIcon(iconId);
    final iconColor =
        Provider.of<Weather>(context).getTheCorrectIconColor(iconId);
    return Container(
      padding: EdgeInsets.only(right: 15),
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
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
              SizedBox(
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
