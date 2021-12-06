import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:flutter_weather_app/model/model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key, this.parseWeatherData, this.parseAirPollution})
      : super(key: key);

  final dynamic parseWeatherData;
  final dynamic parseAirPollution;

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Model model = Model();
  String cityname = 'cityname';
  int? temp;
  Widget? icon;
  Widget? airIcon;
  Widget? airState;
  String? des;
  double? dust1;
  double? dust2;
  var date = DateTime.now();
  @override
  void initState() {
    super.initState();
    upateData(widget.parseWeatherData, widget.parseAirPollution);
  }

  void upateData(dynamic weatherData, dynamic airData) {
    //온도.
    double? temp2 = weatherData['main']['temp'];
    temp = temp2!.round();
    //온도에 따른 날씨 아이콘기준.
    int condition = weatherData['weather'][0]['id'];
    icon = model.getWeatherIcon(condition);
    //대기질에 따른 대기질지수 아이콘.
    int index = airData['list'][0]['main']['aqi'];
    airIcon = model.getAirIcon(index);
    airState = model.getAirCondition(index);
    //미세먼지 초미세먼지 데이터.
    dust1 = airData['list'][0]['components']['pm10'].toDouble();
    dust2 = airData['list'][0]['components']['pm2_5'].toDouble();
    //날씨 설명.
    des = weatherData['weather'][0]['description'];
    //도시 이름
    cityname = weatherData['name'];

    print(temp);
    print(cityname);
  }

  String getSystemTitme() {
    var now = DateTime.now();

    return DateFormat("h:mm a").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        //title: Text(''),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.near_me),
          color: Colors.black,
          iconSize: 40.0,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.location_searching),
            color: Colors.black,
            iconSize: 40.0,
          ),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'images/background.gif',
              fit: BoxFit.cover,
              height: double.infinity,
            ),
            Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // cityname과 시간 날짜 연도 배치
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 150.0,
                              ),
                              Text('$cityname',
                                  style: GoogleFonts.lato(
                                      fontSize: 35.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              Row(
                                children: [
                                  TimerBuilder.periodic(Duration(minutes: 1),
                                      builder: (context) {
                                    print('${getSystemTitme()}');
                                    return Text(
                                      '${getSystemTitme()}',
                                      style: GoogleFonts.lato(
                                          fontSize: 16.0, color: Colors.black),
                                    );
                                  }),
                                  Text(
                                    DateFormat(' - EEEE').format(date),
                                    style: GoogleFonts.lato(
                                        fontSize: 16.0, color: Colors.black),
                                  ),
                                  Text(
                                      DateFormat(' d MMM, yyy').format(
                                        date,
                                      ),
                                      style: GoogleFonts.lato(
                                          fontSize: 16.0, color: Colors.black))
                                ],
                              )
                            ],
                          ),
                          //현재 기온과 날씨이미지 및 설명 배치
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('$temp\u2103',
                                  style: GoogleFonts.lato(
                                      fontSize: 85.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              Row(
                                children: [
                                  icon!,
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    '$des',
                                    style: GoogleFonts.aleo(
                                        fontSize: 20.0, color: Colors.black),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Divider(
                          height: 15.0,
                          thickness: 4.0,
                          color: Colors.blueGrey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //대기질지수 UI 배치
                            Column(
                              children: [
                                Text(
                                  'AQI(대기질지수)',
                                  style: GoogleFonts.aleo(
                                      fontSize: 14.0, color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                airIcon!,
                                SizedBox(
                                  height: 10.0,
                                ),
                                airState!,
                              ],
                            ),
                            //미세먼지 UI 배치
                            Column(
                              children: [
                                Text(
                                  '미세먼지',
                                  style: GoogleFonts.aleo(
                                      fontSize: 14.0, color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  '$dust1',
                                  style: GoogleFonts.aleo(
                                      fontSize: 24.0, color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  '㎍/㎥',
                                  style: GoogleFonts.aleo(
                                      fontSize: 14.0, color: Colors.black),
                                ),
                              ],
                            ),
                            //초미세먼지 UI 배치
                            Column(
                              children: [
                                Text(
                                  '초미세먼지',
                                  style: GoogleFonts.aleo(
                                      fontSize: 14.0, color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  '$dust2',
                                  style: GoogleFonts.aleo(
                                      fontSize: 24.0, color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  '㎍/㎥+-',
                                  style: GoogleFonts.aleo(
                                      fontSize: 14.0, color: Colors.black),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
