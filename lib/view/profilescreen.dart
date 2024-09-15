import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:healthaid/Models/Staticmodel.dart';
import 'package:healthaid/view/Loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSettingsScreen extends StatefulWidget {
  @override
  _ProfileSettingsScreenState createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    String name = Staticdata.userModel!.Name.toString();
    // Get screen dimensions using MediaQuery
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    // Define proportions based on the screen size
    var avatarRadius = width * 0.15; // 15% of screen width
    var fontSizeTitle = width * 0.08; // 8% of screen width
    var fontSizeSubtitle = width * 0.05; // 5% of screen width
    var buttonHeight = height * 0.07; // 7% of screen height
    var padding = width * 0.04; // 4% of screen width

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile & Settings',
                  style: TextStyle(
                    fontSize: fontSizeTitle,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: padding),
                Card(
                  color: Colors.white.withOpacity(0.1),
                  child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      children: [
                        CircleAvatar(
                            radius: avatarRadius,
                            backgroundImage: AssetImage('assets/on1.png')),
                        SizedBox(height: padding),
                        Text(
                          Staticdata.userModel!.Name.toString(),
                          style: TextStyle(
                            fontSize: fontSizeSubtitle,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          Staticdata.userModel!.Email.toString(),
                          style: TextStyle(
                            fontSize:
                                fontSizeSubtitle * 0.75, // 75% of subtitle size
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(height: padding),
                        ElevatedButton(
                          onPressed: () {
                            // Handle edit profile logic
                          },
                          child: Text('Edit Profile'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.blue,
                            backgroundColor: Colors.white,
                            minimumSize: Size(double.infinity, buttonHeight),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: padding),
                Card(
                  color: Colors.white.withOpacity(0.1),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.notifications, color: Colors.white),
                        title: Text(
                          'Notifications',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: SizedBox(
                          width: 50, // Constrain switch width
                          child: Switch(
                            value: _notificationsEnabled,
                            onChanged: (val) {
                              setState(() {
                                _notificationsEnabled = val;
                              });
                            },
                            activeColor:
                                Colors.blue, // Color when the switch is ON
                            inactiveThumbColor: Colors
                                .grey, // Thumb color when the switch is OFF
                            inactiveTrackColor: Colors.grey[
                                400], // Track color when the switch is OFF
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.dark_mode, color: Colors.white),
                        title: Text(
                          'Dark Mode',
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: SizedBox(
                          width: 50, // Constrain switch width
                          child: Switch(
                            value: _notificationsEnabled,
                            onChanged: (val) {
                              setState(() {
                                _notificationsEnabled = val;
                              });
                            },
                            activeColor:
                                Colors.blue, // Color when the switch is ON
                            inactiveThumbColor: Colors
                                .grey, // Thumb color when the switch is OFF
                            inactiveTrackColor: Colors.grey[
                                400], // Track color when the switch is OFF
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: padding),
                ElevatedButton(
                  onPressed: () {
                    // Handle logout logic
                    logout(context);

                  },
                  child: Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                    minimumSize: Size(double.infinity, buttonHeight),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
  Future<void> logout(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getKeys();
    preferences.clear();

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
