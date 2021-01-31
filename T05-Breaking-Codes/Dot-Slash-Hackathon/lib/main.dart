import 'package:dotslash_hackathon/screens/check_connectivity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    EasyLocalization(
      child: MyApp(),
      supportedLocales: [Locale('en'), Locale('hi'), Locale('gu')],
      path: 'assets/lang',
      fallbackLocale: Locale('en'),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      debugShowCheckedModeBanner: false,
      title: 'DotSlash',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CheckConnectivity(),
    );
  }
}
