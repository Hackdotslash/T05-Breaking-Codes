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
      length: 2,
      child: Scaffold(
        body: _currentIndex == 0
            ? Center(child: Text('Doctor info'))
            : Center(child: Text('About us')),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.healing), label: "Doctor's data"),
            BottomNavigationBarItem(icon: Icon(Icons.info), label: "About us"),
          ],
        ),
      ),
    );
  }
}
