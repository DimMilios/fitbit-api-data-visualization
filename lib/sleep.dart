import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:semester_project/dataService.dart';
import 'package:semester_project/menu.dart';
import './sleepData.dart';

class SleepPage extends StatefulWidget {
  @override
  _SleepPageState createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  final DataService dataService = DataService();
  bool _isLoading = true;
  List<SleepData> _sleepData = [];

  // Δημιουργεί τη λίστα με τα δεδομένα του ύπνου
  // που θα κάνει render το Chart
  List<charts.Series<SleepData, DateTime>> _createDataList(
      List<SleepData> stepsData) {
    return [
      new charts.Series<SleepData, DateTime>(
        id: 'Sleep',
        colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
        domainFn: (SleepData sleep, _) => DateTime.parse(sleep.dateOfSleep),
        measureFn: (SleepData sleep, _) => sleep.duration / 1000 / 60,
        data: stepsData,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    loadSleepData();
  }

  // Φορτώνει τα απαραίτητα δεδομένα για την αρχικοποίηση του state
  void loadSleepData() async {
    List<SleepData> data = await dataService.getSleepData();

    setState(() {
      _sleepData = [...data];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sleep'),
        backgroundColor: Colors.blue[300],
      ),
      drawer: Menu(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    'Sleep',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Flexible(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: charts.TimeSeriesChart(_createDataList(_sleepData),
                          animate: true,
                          defaultRenderer: new charts.LineRendererConfig(
                            customRendererId: 'customArea',
                            includeArea: true,
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    'Days',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
    );
  }
}
