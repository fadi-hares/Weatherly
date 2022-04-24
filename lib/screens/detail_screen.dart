import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../const/const.dart';
import '../providers/weather_provider.dart';
import '../widgets/next_week_weather_container.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.read<WeatherProvider>();

    String cityName() {
      String fullName = weatherProvider.state.weather.timeZone;
      return fullName.split('/')[1];
    }

    final weather = context.read<WeatherProvider>();
    final String iconId = weather.state.weather.icon;
    final String svgImage = weather.getTheCorrectWeatherSVG(iconId);

    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 4, 61),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 0, 4, 61),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(cityName()),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  child: Container(
                    alignment: Alignment.center,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.only(
                      right: size.width * 0.05,
                      left: size.width * 0.05,
                      top: size.height * 0.1,
                      bottom: size.height * 0.05,
                    ),
                    margin: EdgeInsets.only(
                      bottom: size.height * 0.05,
                      top: size.height * 0.05,
                    ),
                    child: FittedBox(
                      child: Text(
                        weather.state.weather.alerts == null
                            ? 'No alerts today'
                            : weather.state.weather.alerts!['description'],
                        style: kDetailScreenTxtStyle.copyWith(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 1,
                  child: SizedBox(
                      width: 100,
                      height: 100,
                      child:
                          SvgPicture.asset('assets/Animated-Icons/$svgImage')),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Next Week',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.49,
                  child: ListView.builder(
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      return NextWeekWeatherContainer(
                        date: weather.state.weather.daily[index]['dt'],
                        iconId: weather.state.weather.daily[index]['weather'][0]
                            ['icon'],
                        maxTemp: weather.state.weather.daily[index]['temp']
                            ['max'],
                        minTemp: weather.state.weather.daily[index]['temp']
                            ['min'],
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
