import 'package:dotslash_hackathon/screens/about_us_page.dart';
import 'package:dotslash_hackathon/screens/chat_sceen.dart';
import 'package:dotslash_hackathon/screens/doctor_info_page.dart';
import 'package:dotslash_hackathon/screens/event_info_page.dart';
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
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Home Screen',
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
        body: _currentIndex == 0
            ? DoctorInfo()
            : _currentIndex == 1
                ? EventPage()
                : _currentIndex == 2
                    ? ChatScreen()
                    : AboutUs(),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.grey,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.healing), label: 'Nearby doctors'),
            BottomNavigationBarItem(
                icon: Icon(Icons.event), label: 'Nearby events'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat bot'),
            BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About us')
          ],
        ),
      ),
    );
  }
}
