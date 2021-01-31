import 'package:dotslash_hackathon/screens/fetch_data_screen.dart';
import 'package:dotslash_hackathon/screens/login_screen.dart';
import 'package:dotslash_hackathon/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckScreen extends StatefulWidget {
  @override
  _CheckScreenState createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  @override
  void initState() {
    super.initState();
    checkUserStatus();
  }

  checkUserStatus() async {
    final pref = await SharedPreferences.getInstance();
    final status = pref.getString(kStatusText);
    if (status == null || status == kLogOutText)
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    else
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => FetchData()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
