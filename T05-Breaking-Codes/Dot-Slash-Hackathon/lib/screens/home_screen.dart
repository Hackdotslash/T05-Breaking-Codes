import 'package:dotslash_hackathon/screens/login_screen.dart';
import 'package:dotslash_hackathon/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'App Name',
          style: kHeaderTextStyle,
        ),
        actions: [
          RaisedButton(
            child: Text(
              'Log Out',
              style: kButtonTextStyle,
            ),
            color: kButtonColor,
            onPressed: () async {
              final pref = await SharedPreferences.getInstance();
              await pref.clear();
              pref.setString(kStatusText, kLogOutText);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          )
        ],
      ),
      body: Center(
        child: Text(
          'Home Screen',
          style: kTitleTextSyyle,
        ),
      ),
    );
  }
}
