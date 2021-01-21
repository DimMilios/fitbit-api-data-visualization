// Αντιπροσωπεύει τα δεδομένα των βημάτων και των θερμίδων
class StepsData {
  final String startTime;
  final int steps;
  final int calories;

  StepsData({this.startTime, this.steps, this.calories});

  // Δημιουργεί ένα object τύπου StepsData από dynamic json δεδομένα
  factory StepsData.fromJson(Map<String, dynamic> json) {
    var date = DateTime.parse(json['startTime']);

    return StepsData(
      startTime: '${date.day}-${date.month}',
      steps: json['steps'] as int,
      calories: json['calories'] as int,
    );
  }
}
