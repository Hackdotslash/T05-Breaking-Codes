import 'package:dotslash_hackathon/models/Language.dart';
import 'package:dotslash_hackathon/screens/about_us_page.dart';
import 'package:dotslash_hackathon/screens/doctor_info_page.dart';
import 'package:dotslash_hackathon/screens/event_info_page.dart';
import 'package:dotslash_hackathon/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class OfflineHomeScreen extends StatefulWidget {
  @override
  _OfflineHomeScreenState createState() => _OfflineHomeScreenState();
}

class _OfflineHomeScreenState extends State<OfflineHomeScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'headingText',
            style: kHeaderTextStyle,
          ).tr(),
          actions: [
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
                icon: Icon(Icons.info), title: Text('aboutText'.tr()))
          ],
        ),
      ),
    );
  }
}
