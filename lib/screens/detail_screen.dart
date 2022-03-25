import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/const/const.dart';
import 'package:weather_app/providers/weather.dart';
import 'package:weather_app/widgets/next_week_weather_container.dart';

class DetailScreen extends StatelessWidget {
  final Map<dynamic, dynamic> data;

  DetailScreen(this.data);

  @override
  Widget build(BuildContext context) {
    final iconId = data['current']['weather'][0]['icon'];
    final String svgImage =
        Provider.of<Weather>(context).getTheCorrectWeatherSVG(iconId);

    String cityName() {
      String fullName = data['timezone'];
      return fullName.split('/')[1];
    }

    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 4, 61),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 0, 4, 61),
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
                        data['alerts'] == null
                            ? 'No alerts today'
                            : data['alerts'][0]['description'],
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
                Text(
                  'Next Week',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: size.height * 0.49,
                  child: ListView.builder(
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      return NextWeekWeatherContainer(
                        date: data['daily'][index]['dt'],
                        iconId: data['daily'][index]['weather'][0]['icon'],
                        maxTemp: data['daily'][index]['temp']['max'],
                        minTemp: data['daily'][index]['temp']['min'],
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
