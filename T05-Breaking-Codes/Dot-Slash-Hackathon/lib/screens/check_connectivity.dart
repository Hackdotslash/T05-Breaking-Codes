import 'package:dotslash_hackathon/screens/check_screen.dart';
import 'package:dotslash_hackathon/screens/offline_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CheckConnectivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return OfflineBuilder(
            connectivityBuilder: (BuildContext context,
                ConnectivityResult connectivity, Widget child) {
              if (connectivity != ConnectivityResult.none) {
                Fluttertoast.showToast(msg: "Online mode activated");
                return CheckScreen();
              } else {
                Fluttertoast.showToast(msg: "Offline mode activated");
                return OfflineHomeScreen();
              }
            },
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
