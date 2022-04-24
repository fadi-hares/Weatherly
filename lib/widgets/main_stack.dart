// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../main.dart';
import '../providers/weather_provider.dart';
import '../screens/detail_screen.dart';
import '../screens/main_screen.dart';

class MainStack extends StatefulWidget {
  const MainStack({Key? key}) : super(key: key);

  @override
  State<MainStack> createState() => _MainStackState();
}

class _MainStackState extends State<MainStack>
    with SingleTickerProviderStateMixin {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final PageController pageController = PageController(initialPage: 0);
  int pageCount = 0;

  Widget _showWeather() {
    final error = context.read<WeatherProvider>().state.error.error;
    final weatherState = context.watch<WeatherProvider>().state;
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    if (weatherState.weatherStatus == WeatherStatus.loading) {
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: CircularProgressIndicator(
            color: secondaryColor,
          ),
        ),
      );
    }

    if (weatherState.weatherStatus == WeatherStatus.error) {
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SmartRefresher(
          scrollDirection: Axis.vertical,
          controller: _refreshController,
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropMaterialHeader(
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          onRefresh: () {
            Future.delayed(const Duration(seconds: 1)).then(
              (_) => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const MyApp(),
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Text(
                '$error\n\nplease pull to refresh',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: secondaryColor,
                ),
              ),
            ),
          ),
        ),
      );
    }

    if (weatherState.weatherStatus == WeatherStatus.loaded) {
      return Stack(
        children: [
          PageView(
            onPageChanged: (value) {
              setState(() {
                pageCount = value;
              });
            },
            controller: pageController,
            children: [
              const MainScreen(),
              const DetailScreen(),
            ],
          ),
          Positioned(
            left: 1,
            right: 1,
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  maintainState: true,
                  maintainAnimation: true,
                  maintainSize: true,
                  visible: pageCount == 0 ? false : true,
                  child: TextButton(
                    onPressed: () {
                      pageController.animateToPage(0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                    child: const Text(
                      'Back',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                AnimatedSmoothIndicator(
                  duration: const Duration(milliseconds: 500),
                  activeIndex: pageCount,
                  count: 2,
                  effect: const WormEffect(
                    activeDotColor: Colors.orange,
                    dotColor: Colors.white,
                    dotHeight: 15,
                    dotWidth: 15,
                  ),
                ),
                Visibility(
                  maintainState: true,
                  maintainAnimation: true,
                  maintainSize: true,
                  visible: pageCount == 0 ? true : false,
                  child: TextButton(
                    onPressed: () {
                      pageController.animateToPage(1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        color: Color.fromARGB(255, 23, 22, 119),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
    return const Scaffold(
      body: Center(
        child: Text('error'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _showWeather();
  }
}
