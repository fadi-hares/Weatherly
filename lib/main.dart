import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather.dart';
import 'package:weather_app/widgets/main_stack.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Weather(),
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
          home: const MainStack()),
    );
  }
}
