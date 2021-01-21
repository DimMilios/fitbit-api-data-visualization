// Αντιπροσωπεύει τα δεδομένα των καρδιακών παλμών
class HeartRateData {
  final String dateTime;
  final int heartRate;

  HeartRateData({this.dateTime, this.heartRate});

  // Δημιουργεί ένα object τύπου HeartRateData από dynamic json δεδομένα
  factory HeartRateData.fromJson(Map<String, dynamic> json) {
    var date = DateTime.parse(json['dateTime']);

    return HeartRateData(
        dateTime: '${date.day}-${date.month}',
        heartRate: json['heartRate'] as int);
  }
}
