import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:semester_project/menu.dart';
import './stepsData.dart';
import 'package:semester_project/dashboard.dart';

class StepsPage extends StatelessWidget {
  // Δημιουργεί τη λίστα με τα δεδομένα των βημάτων και των θερμίδων
  // που θα κάνει render το Chart
  List<charts.Series<StepsData, String>> _createDataList(
      List<StepsData> stepsData) {
    return [
      new charts.Series<StepsData, String>(
        id: 'Steps',
        domainFn: (StepsData steps, _) => steps.startTime,
        measureFn: (StepsData steps, _) => steps.steps,
        data: stepsData,
      ),
      new charts.Series<StepsData, String>(
        id: 'Calories',
        colorFn: (_, __) => charts.MaterialPalette.deepOrange.makeShades(5)[2],
        domainFn: (StepsData steps, _) => steps.startTime,
        measureFn: (StepsData steps, _) => steps.calories,
        data: stepsData,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Steps'),
        backgroundColor: Colors.blue[300],
      ),
      drawer: Menu(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              'Steps/Calories',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: charts.BarChart(
                _createDataList(stepsData),
                animate: true,
                barGroupingType: charts.BarGroupingType.grouped,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
