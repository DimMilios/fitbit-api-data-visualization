import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:semester_project/dataService.dart';
import 'package:semester_project/menu.dart';
import './stepsData.dart';
import './heartRateData.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

List<HeartRateData> heartrateData = [];
List<StepsData> stepsData = [];

class _DashboardPageState extends State<DashboardPage> {
  bool _isLoading = true;
  final DataService dataService = DataService();

  @override
  void initState() {
    super.initState();

    loadData();
  }

  // Φορτώνει τα απαραίτητα δεδομένα για την αρχικοποίηση του state
  void loadData() async {
    List<HeartRateData> heartrate = await dataService.getHeartRateData();
    List<StepsData> steps = await dataService.getStepsData();

    setState(() {
      heartrateData = [...heartrate];
      stepsData = [...steps];
      _isLoading = false;
    });
  }

  // Αντιπροσωπεύει ένα αντικείμενο που δημιουργείται στην οθόνη του dashboard
  Widget gridViewItem(GridItemContent content, String heading, Color color,
      Function tapHandler) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(24.0),
      child: InkWell(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          heading,
                          style: TextStyle(color: color, fontSize: 20.0),
                        ),
                      ),
                      content.iconData != null
                          // Έλεγχος για τον τύπο του περιεχομένου του κάθε grid item στο StaggeredGridView
                          ? Padding(
                              // Εικόνα
                              padding: EdgeInsets.all(16.0),
                              child: Icon(content.iconData, size: 36.0),
                            )
                          : Padding(
                              // Γράφημα
                              padding: EdgeInsets.all(16.0),
                              child: content.graph,
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: tapHandler,
      ),
    );
  }

  // Δημιουργεί ένα SparkLine με τα δεδομένα των καρδιακών παλμών
  Widget createSparkline() {
    return Sparkline(
      data: heartrateData.map((data) => data.heartRate.toDouble()).toList(),
      lineColor: Colors.orange,
      pointsMode: PointsMode.all,
      pointSize: 8.0,
    );
  }

  // Δημιουργεί μια πίτα με τα δεδομένα της τελευταίας εγγραφής
  // των βημάτων του χρήστη για τη σύγκριση με τον ημερήσιο στόχο του
  Widget createCircularStackEntry() {
    double steps = stepsData.last.steps
        .toDouble(); // Παίρνει το τελευταίο στοιχείο της λίστας

    return AnimatedCircularChart(
        size: Size(100.0, 100.0),
        chartType: CircularChartType.Pie,
        initialChartData: <CircularStackEntry>[
          new CircularStackEntry(
            <CircularSegmentEntry>[
              new CircularSegmentEntry(8000.0, Colors.grey, rankKey: 'Target'),
              new CircularSegmentEntry(steps, Colors.orange, rankKey: 'Value'),
            ],
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Menu(),
        appBar: AppBar(
          backgroundColor: Colors.blue[300],
          title: Text('Dashboard'),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : StaggeredGridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 12.0,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                children: [
                  gridViewItem(
                      GridItemContent(graph: createSparkline()),
                      'Heart Rate',
                      Colors.blue,
                      () => Navigator.of(context).pushNamed('/heartrate')),
                  gridViewItem(
                      GridItemContent(graph: createCircularStackEntry()),
                      'Steps',
                      Colors.blue,
                      () => Navigator.of(context).pushNamed('/steps')),
                  gridViewItem(
                      GridItemContent(iconData: Icons.person),
                      'Me',
                      Colors.blue,
                      () => Navigator.of(context).pushNamed('/demographics')),
                  gridViewItem(
                      GridItemContent(iconData: Icons.bedtime),
                      'Sleep',
                      Colors.blue,
                      () => Navigator.of(context).pushNamed('/sleep')),
                ],
                staggeredTiles: [
                  StaggeredTile.extent(2, 260.0),
                  StaggeredTile.extent(1, 280.0),
                  StaggeredTile.extent(1, 130.0),
                  StaggeredTile.extent(1, 130.0),
                ],
              ));
  }
}

class GridItemContent {
  IconData iconData = null;
  Widget graph = null;

  GridItemContent({this.iconData, this.graph});
}
