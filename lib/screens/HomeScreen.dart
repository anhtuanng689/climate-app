import 'package:flutter/material.dart';
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

  bool _isLoading = false;

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
    final weatherData = Provider.of<WeatherProvider>(context, listen: false);
    weatherData.getWeatherData();
    _isLoading = false;
  }

  // Future<void> _getDrawerData() async {
  //   _isDrawer = true;
  //   weatherData.getWeatherLocationEndDrawer();
  //   _isDrawer = false;
  // }

  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<WeatherProvider>(context, listen: false).getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context, listen: false);
    final myContext = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    print('is loading: $_isLoading');
    print('wea loading: ${weatherData.loading}');
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
                                                delay: 0.66,
                                                child: HourlyForecast(
                                                    weatherData.hourlyWeather),
                                              ),
                                              FadeIn(
                                                delay: 1,
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
                                              FadeIn(
                                                  delay: 1,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        right: 15),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          'Data from OpenWeatherMap and AirVisual',
                                                          style: TextStyle(
                                                              color: Colors.grey
                                                                  .shade500),
                                                        )
                                                      ],
                                                    ),
                                                  )),
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
