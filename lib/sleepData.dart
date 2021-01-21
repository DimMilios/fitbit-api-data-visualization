// Αντιπροσωπεύει τα δεδομένα του ύπνου
class SleepData {
  final String dateOfSleep;
  final int duration;

  SleepData({this.dateOfSleep, this.duration});

  // Δημιουργεί ένα object τύπου SleepData από dynamic json δεδομένα
  factory SleepData.fromJson(Map<String, dynamic> json) {
    return SleepData(
        dateOfSleep: json['dateOfSleep'] as String,
        duration: json['duration'] as int);
  }
}
