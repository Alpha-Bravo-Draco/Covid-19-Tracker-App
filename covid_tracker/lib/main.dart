import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/countries_list.dart';
import 'package:flutter_application_2/screens/homepage.dart';
import 'package:flutter_application_2/screens/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/homepage': (context) => const Homepage(),
        'countries_list': (context) => const CountriesList(),
      },
    );
  }
}
