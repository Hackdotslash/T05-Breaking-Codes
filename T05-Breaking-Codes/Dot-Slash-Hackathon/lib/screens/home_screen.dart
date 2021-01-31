import 'package:dotslash_hackathon/models/Language.dart';
import 'package:dotslash_hackathon/screens/about_us_page.dart';
import 'package:dotslash_hackathon/screens/chat_sceen.dart';
import 'package:dotslash_hackathon/screens/doctor_info_page.dart';
import 'package:dotslash_hackathon/screens/documents_page.dart';
import 'package:dotslash_hackathon/screens/event_info_page.dart';
import 'package:dotslash_hackathon/screens/login_screen.dart';
import 'package:dotslash_hackathon/screens/vaccine_page.dart';
import 'package:dotslash_hackathon/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return DefaultTabController(
      length: 5,
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
=======
    return Scaffold(
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
>>>>>>> 3ada0ad7e2399a554aedc1ff45a46c8336207e67
            ),
            SizedBox(
              width:10
            ),
            GestureDetector(
              child: Center(
                child: Text(
                  'SOS',
                  style: TextStyle(fontSize: 15, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: () async {
                final pref = await SharedPreferences.getInstance();
                String emergency = pref.getString(emergencyContact);
                print(emergency);
                await launch('tel://+91' + emergency);
              },
            ),
            Padding(
              padding: EdgeInsets.all(1),
              child: DropdownButton(
                onChanged: (Language val) {
                  if (val.code == 'hi') {
                    context.locale = Locale('hi');
                  } else if (val.code == 'gu') {
                    context.locale = Locale('gu');
                  } else {
                    context.locale = Locale('en');
                  }
                },
                icon: Icon(Icons.language),
                items: Language.getLanguages()
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.name),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
        body: _currentIndex == 0
            ? DoctorInfo()
            : _currentIndex == 1
                ? EventPage()
                : _currentIndex == 2
                    ? UploadDocuments()
                    : _currentIndex == 3
                        ? VaccinePage()
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
                icon: Icon(Icons.picture_as_pdf),
                title: Text('documents').tr()),
            BottomNavigationBarItem(
                icon: Icon(Icons.medical_services),
                title: Text('vaccine').tr()),
            BottomNavigationBarItem(
                icon: Icon(Icons.info), title: Text('aboutText'.tr())),
          ],
        ),
      ),
    );
  }
}
