import 'package:dotslash_hackathon/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  String userId = '';
  bool isLoading = false;

  getUserId() async {
    setState(() {
      isLoading = true;
    });
    final pref = await SharedPreferences.getInstance();
    String getUid = pref.getString(uid);
    print(getUid);
    setState(() {
      userId = getUid;
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'My user Id:',
              style: kTitleTextSyyle,
            ),
            isLoading
                ? CircularProgressIndicator()
                : Text(
                    userId,
                    style: kNormalTextStyle,
                  )
          ],
        ),
      ),
    );
  }
}
