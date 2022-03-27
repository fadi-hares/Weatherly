import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherImage extends StatelessWidget {
  late String icon;

  WeatherImage(this.icon);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    String svgImage =
        Provider.of<Weather>(context).getTheCorrectWeatherSVG(icon);

    return Container(
      margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
      child: SizedBox(
        height: size.width * 0.4,
        width: size.width * 0.4,
        child: SvgPicture.asset(
          'assets/Animated-Icons/$svgImage',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
