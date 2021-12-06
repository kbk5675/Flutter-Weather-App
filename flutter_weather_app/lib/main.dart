import 'package:flutter/material.dart';
import 'package:flutter_weather_app/screens/loading.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(primaryColor: Colors.brown[300]),
      home: const LoadingScreen(),
    );
  }
}
