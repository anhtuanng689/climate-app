import 'package:flutter/material.dart';
import 'package:flutter_weather/services/notification.dart';
import 'package:flutter_weather/widgets/endDrawer.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../provider/weatherProvider.dart';
import '../widgets/WeatherInfo.dart';
import '../widgets/fadeIn.dart';
import '../widgets/hourlyForecast.dart';
import '../widgets/locationError.dart';
import '../widgets/mainWeather.dart';
import '../widgets/requestError.dart';
import '../widgets/searchBar.dart';
import '../widgets/weatherDetail.dart';
import '../widgets/sevenDayForecast.dart';
import '../widgets/aqi.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();

  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  Future<void> _getData() async {
    _isLoading = true;
    print('getting...');
    final weatherData = Provider.of<WeatherProvider>(context, listen: false);
    weatherData.getWeatherData();
    print('getting done');
    _isLoading = false;
  }

  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<WeatherProvider>(context, listen: false).getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context);
    final myContext = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final notification = Provider.of<NotificationService>(context);

    // print('is loading: $_isLoading');
    // print('wea loading: ${weatherData.loading}');
    // print('deny location: ${weatherData.isLocationError}');
    print('list weather: ${weatherData.listWeather}');
    print('list city: ${weatherData.cityList}');
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        endDrawerEnableOpenDragGesture: false,
        endDrawer: EndDrawer(
          lWeather: weatherData.listWeather,
          cityList: weatherData.cityList,
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: myContext.primaryColor,
                ),
              )
            : weatherData.loading
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: myContext.primaryColor,
                    ),
                  )
                : weatherData.isLocationError
                    ? LocationError()
                    : Column(
                        children: [
                          SearchBar(),
                          SmoothPageIndicator(
                            controller: _pageController,
                            count: 2,
                            effect: ExpandingDotsEffect(
                              activeDotColor: myContext.primaryColor,
                              dotHeight: 6,
                              dotWidth: 6,
                            ),
                          ),
                          weatherData.isRequestError
                              ? RequestError()
                              : Expanded(
                                  child: PageView(
                                    controller: _pageController,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        width: mediaQuery.size.width,
                                        child: RefreshIndicator(
                                          onRefresh: () =>
                                              _refreshData(context),
                                          backgroundColor: Colors.blue,
                                          child: ListView(
                                            children: [
                                              FadeIn(
                                                  delay: 0,
                                                  child: MainWeather(
                                                      wData: weatherData)),
                                              FadeIn(
                                                delay: 0.33,
                                                child: WeatherInfo(
                                                    wData: weatherData
                                                        .currentWeather),
                                              ),
                                              FadeIn(
                                                delay: 0.44,
                                                child: HourlyForecast(
                                                    weatherData.hourlyWeather),
                                              ),
                                              FadeIn(
                                                delay: 0.55,
                                                child:
                                                    Aqi(wData: weatherData.aqi),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: mediaQuery.size.height,
                                        width: mediaQuery.size.width,
                                        child: RefreshIndicator(
                                          onRefresh: () =>
                                              _refreshData(context),
                                          backgroundColor: Colors.blue,
                                          child: ListView(
                                            children: [
                                              FadeIn(
                                                delay: 0.33,
                                                child: SevenDayForecast(
                                                  wData: weatherData,
                                                  dWeather: weatherData
                                                      .sevenDayWeather,
                                                ),
                                              ),
                                              FadeIn(
                                                  delay: 0.66,
                                                  child: WeatherDetail(
                                                      wData: weatherData)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
      ),
    );
  }
}
