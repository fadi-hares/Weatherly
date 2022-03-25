import 'package:flutter/material.dart';
import 'package:weather_app/models/info.dart';
import 'package:weather_app/screens/map_screen.dart';
import 'package:weather_app/widgets/weather_data.dart';
import 'package:weather_app/widgets/weather_image.dart';
import 'package:weather_app/widgets/weather_info.dart';

class MainScreen extends StatefulWidget {
  final Map<dynamic, dynamic> data;
  final bool isValid;
  final Info info;

  MainScreen({
    required this.data,
    required this.info,
    required this.isValid,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String cityName() {
    try {
      String fullName = widget.data['timezone'];
      return fullName.split('/')[1];
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    Color secondaryColor = Theme.of(context).colorScheme.secondary;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // show on map ....
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MapScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.location_pin,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    Text(
                      cityName(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // IconButton(
                //   onPressed: () {
                //     // rebuild the app
                //     Navigator.of(context).pushReplacement(
                //       MaterialPageRoute(
                //         builder: (context) => MainStack(),
                //       ),
                //     );
                //   },
                //   icon: Icon(
                //     Icons.redo,
                //     color: Theme.of(context).colorScheme.secondary,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            WeatherImage(widget.info.icon),
            WeatherInfo(
              condition: widget.info.situation,
              humidity: widget.info.humidity,
              temp: widget.info.temprature,
              windSpeed: widget.info.windSpeed,
            ),
            WeatherData(widget.data),
          ],
        ),
      ),
    );
  }
}
