import 'package:dotslash_hackathon/screens/about_us_page.dart';
import 'package:dotslash_hackathon/screens/doctor_info_page.dart';
import 'package:dotslash_hackathon/screens/event_info_page.dart';
import 'package:flutter/material.dart';

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
        body: _currentIndex == 0
            ? DoctorInfo()
            : _currentIndex == 1
                ? EventPage()
                : AboutUs(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.healing), label: "Nearby doctors"),
            BottomNavigationBarItem(
                icon: Icon(Icons.event), label: "Nearby Events"),
            BottomNavigationBarItem(icon: Icon(Icons.info), label: "About us"),
          ],
        ),
      ),
    );
  }
}
