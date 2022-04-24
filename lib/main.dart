import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/weather_provider.dart';
import 'repositories/weather_repositories.dart';
import 'services/device_loaction_service.dart';
import 'services/weather_api_service.dart';
import 'widgets/main_stack.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<WeatherRepositories>(
          create: (context) {
            DeviceLocationService deviceLocationService =
                DeviceLocationService();
            WeatherApiService weatherApiService = WeatherApiService();
            return WeatherRepositories(
              deviceLocationService: deviceLocationService,
              weatherApiService: weatherApiService,
            );
          },
        ),
        ChangeNotifierProxyProvider<WeatherRepositories, WeatherProvider>(
          create: (context) => WeatherProvider(
            weatherRepositories: context.read<WeatherRepositories>(),
          ),
          update: (context, repo, provider) => provider!..fetchWeatherData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Gilroy',
          primaryColor: const Color.fromARGB(255, 110, 244, 249),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: const Color.fromARGB(255, 23, 22, 119),
          ),
          cardColor: const Color.fromARGB(255, 156, 252, 255),
        ),
        home: const MainStack(),
      ),
    );
  }
}
