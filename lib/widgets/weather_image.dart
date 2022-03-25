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
    Color secondaryColor = Theme.of(context).colorScheme.secondary;
    String svgImage =
        Provider.of<Weather>(context).getTheCorrectWeatherSVG(icon);
    IconData iconData =
        Provider.of<Weather>(context, listen: false).getTheCorrectIcon(icon);
    return Container(
      margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
      child: Container(
        height: size.width * 0.5,
        width: size.width * 0.5,
        child: SvgPicture.asset(
          'assets/Animated-Icons/$svgImage',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
