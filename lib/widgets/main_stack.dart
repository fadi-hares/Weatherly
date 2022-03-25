import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../models/info.dart';
import '../main.dart';
import '../providers/weather.dart';
import '../screens/detail_screen.dart';
import '../screens/main_screen.dart';

class MainStack extends StatefulWidget {
  const MainStack({Key? key}) : super(key: key);

  @override
  State<MainStack> createState() => _MainStackState();
}

class _MainStackState extends State<MainStack>
    with SingleTickerProviderStateMixin {
  Info? info;
  bool isValid = true;
  bool isLoading = false;
  Map<dynamic, dynamic>? data;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final PageController pageController = PageController(initialPage: 0);

  int pageCount = 0;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    try {
      setState(() {
        isLoading = true;
      });
      Map<dynamic, dynamic> weatherData =
          await Provider.of<Weather>(context, listen: false).getWeatherData();
      setState(() {
        isLoading = false;
      });
      final newInfo = Info(
        humidity: weatherData['current']['humidity'],
        icon: weatherData['current']['weather'][0]['icon'],
        situation: weatherData['current']['weather'][0]['main'],
        temprature: weatherData['current']['temp'],
        windSpeed: weatherData['current']['wind_speed'],
      );

      info = newInfo;
      data = weatherData;
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          action: SnackBarAction(
            label: 'Reload',
            textColor: Colors.white,
            onPressed: () {
              setState(() {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ),
                );
              });
            },
          ),
          content: const Text(
            'error has occurre',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
      setState(() {
        isLoading = false;
        isValid = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var secondaryColor = Theme.of(context).colorScheme.secondary;
    return isLoading
        ? Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: Center(
              child: CircularProgressIndicator(
                color: secondaryColor,
              ),
            ),
          )
        : !isValid
            ? Scaffold(
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
                    Future.delayed(Duration(seconds: 1)).then(
                      (_) => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => MainStack(),
                        ),
                      ),
                    );
                  },
                  child: Center(
                    child: Text(
                      'error has been occurred\nplease pull to refresh',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: secondaryColor,
                      ),
                    ),
                  ),
                ),
              )
            : Stack(
                children: [
                  PageView(
                    onPageChanged: (value) {
                      setState(() {
                        pageCount = value;
                      });
                    },
                    controller: pageController,
                    children: [
                      MainScreen(
                        data: data!,
                        info: info!,
                        isValid: isValid,
                      ),
                      DetailScreen(data!),
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
                                  duration: Duration(seconds: 1),
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
                          duration: Duration(seconds: 1),
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
                                  duration: Duration(seconds: 1),
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
}
