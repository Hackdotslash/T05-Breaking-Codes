import 'package:dotslash_hackathon/models/Language.dart';
import 'package:dotslash_hackathon/screens/about_us_page.dart';
import 'package:dotslash_hackathon/screens/chat_sceen.dart';
import 'package:dotslash_hackathon/screens/doctor_info_page.dart';
import 'package:dotslash_hackathon/screens/event_info_page.dart';
import 'package:dotslash_hackathon/screens/login_screen.dart';
import 'package:dotslash_hackathon/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

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
          title: Text(
            'headingText',
            style: kHeaderTextStyle,
          ).tr(),
          actions: [
            GestureDetector(
              child: Center(
                child: Text(
                  'logOutText',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                  textAlign: TextAlign.center,
                ).tr(),
              ),
              onTap: () async {
                final pref = await SharedPreferences.getInstance();
                await pref.clear();
                pref.setString(kStatusText, kLogOutText);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: DropdownButton(
                onChanged: (Language val) {
                  if(val.code == 'hi'){
                    context.locale = Locale('hi');
                  } else if (val.code == 'gu'){
                    context.locale = Locale('gu');
                  } else {
                    context.locale = Locale('en');
                  }
                },
                icon: Icon(Icons.language),
                items: Language.getLanguages().map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.name),
                  ),
                ).toList(),
              ),
            ),
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
                icon: Icon(Icons.healing), title: Text('nearbyDoctors').tr()),
            BottomNavigationBarItem(
                icon: Icon(Icons.event), title: Text('nearbyEvents'.tr())),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat), title: Text('chatText').tr()),
            BottomNavigationBarItem(
                icon: Icon(Icons.info), title: Text('aboutText'.tr()))
          ],
        ),
      ),
    );
  }
}
