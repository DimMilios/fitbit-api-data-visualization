import 'package:flutter/material.dart';
import './dashboard.dart';
import './heartrate.dart';
import './steps.dart';
import './menu.dart';
import './sleep.dart';
import './demographics.dart';

void main() {
  runApp(MaterialApp(
    title: 'Fitbit Analyzer',
    // Η πρώτη οθόνη της εφαρμογής
    initialRoute: '/dashboard',
    // Ορισμός των διαφορετικών οθονών της εφαρμογής
    routes: {
      '/': (context) => App(),
      '/dashboard': (context) => DashboardPage(),
      '/heartrate': (context) => HeartRatePage(),
      '/steps': (context) => StepsPage(),
      '/menu': (context) => Menu(),
      '/sleep': (context) => SleepPage(),
      '/demographics': (context) => DemographicsPage(),
    },
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
