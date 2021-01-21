import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:semester_project/heartRateData.dart';
import 'package:semester_project/menu.dart';
import 'package:semester_project/dashboard.dart';

class HeartRatePage extends StatelessWidget {
  // Δημιουργεί τη λίστα με τα δεδομένα των καρδιακών παλμών
  // που θα κάνει render το BarChart
  List<charts.Series<HeartRateData, String>> _createDataList(
      List<HeartRateData> data) {
    return [
      new charts.Series<HeartRateData, String>(
        id: 'HeartRate',
        colorFn: (_, __) => charts.MaterialPalette.indigo.shadeDefault,
        domainFn: (HeartRateData heartData, _) => heartData.dateTime,
        measureFn: (HeartRateData heartData, _) => heartData.heartRate,
        data: data,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Heart Rate'),
        backgroundColor: Colors.blue[300],
      ),
      drawer: Menu(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              'Heart Rate',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: charts.BarChart(
                  _createDataList(heartrateData),
                  animate: true,
                )),
          ),
        ],
      ),
    );
  }
}
