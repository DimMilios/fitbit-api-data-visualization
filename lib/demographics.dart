import 'package:flutter/material.dart';
import 'package:semester_project/menu.dart';
import './dataService.dart';
import './userProfileData.dart';

class DemographicsPage extends StatefulWidget {
  @override
  _DemographicsPageState createState() => _DemographicsPageState();
}

class _DemographicsPageState extends State<DemographicsPage> {
  final DataService _dataService = DataService();
  UserProfileData _userProfileData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    getUserProfileData();
  }

  // Φορτώνει τα απαραίτητα δεδομένα για την αρχικοποίηση του state
  void getUserProfileData() async {
    UserProfileData response = await _dataService.getUserProfileData();

    setState(() {
      _isLoading = false;
      _userProfileData = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[300],
          title: Text('Demographics'),
        ),
        drawer: Menu(),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child:
                        Image.network(Uri.encodeFull(_userProfileData.avatar)),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      _userProfileData.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      _userProfileData.dateOfBirth,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )));
  }
}
