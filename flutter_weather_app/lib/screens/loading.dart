import 'package:flutter/material.dart';
import 'package:flutter_weather_app/data/my_location.dart';
import 'package:flutter_weather_app/data/network.dart';
import 'package:flutter_weather_app/screens/weather_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = 'abd93a186ce4494bda2b23c2d2bcd6fd';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude3;
  double? longitude3;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;
    print('위도 : $latitude3');
    print('경도 : $longitude3');

    NetWork network = NetWork(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&appid=$apiKey&units=metric',
        'https://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude3&lon=$longitude3&appid=$apiKey');
    var weatherData = await network.getJsonData();
    print('\nWeather 데이터입니다.\n$weatherData\n----------\n');

    var airData = await network.getAirData();
    print('\nAir 데이터입니다.\n$airData\n----------\n');

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WeatherScreen(
        parseWeatherData: weatherData,
        parseAirPollution: airData,
      );
    }));
  }

  // void fetchData() async {

  //     var myjson = parsingData(jsonData)['sys']['id'];
  //     print(myjson);
  //   } else {
  //     print('현재 statusCode : $response.statusCode');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SpinKitFadingFour(
        color: Colors.black,
        size: 80.0,
      ),
    ));
  }
}
