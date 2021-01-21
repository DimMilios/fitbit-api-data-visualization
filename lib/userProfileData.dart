// Αντιπροσωπεύει τα δεδομένα του προφίλ του χρήστη
class UserProfileData {
  final String name;
  final String dateOfBirth;
  final String avatar;

  UserProfileData({this.name, this.dateOfBirth, this.avatar});

  // Δημιουργεί ένα object τύπου UserProfileData από dynamic json δεδομένα
  factory UserProfileData.fromJson(Map<String, dynamic> json) {
    return UserProfileData(
        name: json['displayName'] as String,
        dateOfBirth: json['dateOfBirth'] as String,
        avatar: json['avatar'] as String);
  }
}
