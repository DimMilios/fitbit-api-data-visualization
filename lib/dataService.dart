import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import './stepsData.dart';
import './sleepData.dart';
import './userProfileData.dart';
import './heartRateData.dart';

// Εκτελεί λειτουργίες που έχουν να κάνουν με την επεξεργασία δεδομένων
// απο εξωτερικές πηγές (json αρχεία, http requests στο fitbit api)
class DataService {
  String _token = 'YOUR_FITBIT_TOKEN';

  final String _userProfileUrl = 'https://api.fitbit.com/1/user/-/profile.json';
  final String _sleepUrl =
      'https://api.fitbit.com/1.2/user/-/sleep/list.json?afterDate=2020-10-01&sort=asc&offset=0&limit=10';

  final String heartrateJson = 'assets/json/heartrate.json';
  final String activitiesJson = 'assets/json/response_calories_steps.json';

  // Επιστρέφει δεδομένα και τα μετατρέπει σε τύπο UserProfileData
  // για το προφίλ του χρήστη από το api του fitbit
  Future<UserProfileData> getUserProfileData() async {
    var response = await http.get(Uri.encodeFull(_userProfileUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token'
    });

    if (response.statusCode == 200) {
      dynamic userProfileJson = json.decode(response.body);
      dynamic user = userProfileJson['user'];
      return UserProfileData.fromJson(user);
    } else {
      throw 'Could not fetch user profile data';
    }
  }

  // Επιστρέφει δεδομένα και τα μετατρέπει σε τύπο SleepData
  // σχετικά με τον ύπνο από το api του fitbit
  Future<List<SleepData>> getSleepData() async {
    var response = await http.get(Uri.encodeFull(_sleepUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token'
    });

    if (response.statusCode == 200) {
      var sleepJson = json.decode(response.body);
      List<dynamic> sleep = sleepJson['sleep'];

      return sleep.map((entry) => SleepData.fromJson(entry)).toList();
    } else {
      throw 'Could not fetch sleep data';
    }
  }

  // Φορτώνει ένα αρχείο που είναι αποθηκευμένο τοπικά
  Future<String> loadFile(String fileName) {
    return rootBundle.loadString(fileName);
  }

  // Μετατρέπει(map) json δεδομένα σε λίστα τύπου HeartRateData
  // σχετικά με τους καρδιακούς παλμούς του χρήστη
  Future<List<HeartRateData>> getHeartRateData() async {
    var jsonData = json.decode(await loadFile(heartrateJson));
    List<dynamic> heartActivities = jsonData['activities-heart'];
    return heartActivities
        .map((activity) => HeartRateData.fromJson(activity))
        .toList();
  }

  // Μετατρέπει(map) json δεδομένα σε λίστα τύπου StepsData
  // σχετικά με τα βήματα που έκανε και τις θερμίδες που έχει κάψει ο χρήστης
  Future<List<StepsData>> getStepsData() async {
    var jsonData = json.decode(await loadFile(activitiesJson));
    List<dynamic> activities = jsonData['activities'];

    return activities.map((activity) => StepsData.fromJson(activity)).toList();
  }
}
