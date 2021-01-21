import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  // Αντιπροσωπεύει μια επιλογή του Drawer menu
  Widget buildListTile(String title, IconData icon, Function pageHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 28,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: pageHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 130,
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            alignment: Alignment.centerLeft,
            color: Colors.blue[300],
            child: Text(
              'Health',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
            ),
          ),
          buildListTile('Home', Icons.home_filled,
              () => Navigator.of(context).pushNamed('/dashboard')),
          SizedBox(height: 10),
          buildListTile('Heartrate', Icons.favorite,
              () => Navigator.of(context).pushNamed('/heartrate')),
          SizedBox(height: 10),
          buildListTile('Steps', Icons.directions_walk,
              () => Navigator.of(context).pushNamed('/steps')),
          SizedBox(height: 10),
          buildListTile('Sleep', Icons.bedtime,
              () => Navigator.of(context).pushNamed('/sleep')),
          SizedBox(height: 10),
          buildListTile('Demographics', Icons.person,
              () => Navigator.of(context).pushNamed('/demographics'))
        ],
      ),
    );
  }
}
