import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../providers/weather_provider.dart';

class WeatherImage extends StatelessWidget {
  const WeatherImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String icon = context.read<WeatherProvider>().state.weather.icon;
    var size = MediaQuery.of(context).size;
    String svgImage =
        Provider.of<WeatherProvider>(context).getTheCorrectWeatherSVG(icon);

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
