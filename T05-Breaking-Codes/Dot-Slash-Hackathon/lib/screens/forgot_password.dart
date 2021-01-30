import 'dart:convert';

import 'package:dotslash_hackathon/screens/register_screen.dart';
import 'package:dotslash_hackathon/utils/constants.dart';
import 'package:dotslash_hackathon/utils/db_connection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _email;
  bool _isResettingPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Reset password',
          style: kHeaderTextStyle,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'Login',
                    style: kTitleTextSyyle,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: TextFormField(
                            validator: (String value) {
                              if (value.isEmpty)
                                return 'Email is a required field';
                              return null;
                            },
                            onSaved: (String value) {
                              _email = value;
                            },
                            style: kTextFieldStyle,
                            decoration: InputDecoration(
                                labelText: 'Enter Email',
                                labelStyle: kTextFieldLabelStyle),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: RaisedButton(
                            child: Text(
                              'Reset Password',
                              style: kButtonTextStyle,
                            ),
                            color: kButtonColor,
                            onPressed: () async {
                              if (!_formKey.currentState.validate()) return;
                              _formKey.currentState.save();
                              // setState(() {
                              //   _isLoggingIn = true;
                              // });
                              var resp =
                                  await DBConnections().resetPassword(_email);

                              print(resp.body);
                              if (resp.statusCode == 200) {
                                dynamic output = jsonDecode(resp.body);
                                if (output['success'] == 1)
                                  Fluttertoast.showToast(
                                      msg:
                                          "Email is sent. Reset the password there");
                                else
                                  Fluttertoast.showToast(
                                      msg: "Reset password failed");
                              } else
                                Fluttertoast.showToast(
                                    msg: "Reset password failed");
                              // if (resp['token'] != null) {
                              //   Fluttertoast.showToast(msg: 'Login successful');
                              //   var id = resp['token'];
                              //   final pref =
                              //       await SharedPreferences.getInstance();
                              //   await pref.setString(
                              //       kStatusText, id.toString());
                              //   Navigator.pushReplacement(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) => HomeScreen()));
                              // } else {
                              //   setState(() {
                              //     _isLoggingIn = false;
                              //   });
                              //   Fluttertoast.showToast(
                              //       msg: 'Credentials incorrect');
                              // }
                            },
                          ),
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Not a user?',
                                style: kNormalTextStyle,
                              ),
                              GestureDetector(
                                child: Text(
                                  'Register!',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 18, color: Colors.lightBlue),
                                ),
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterScreen()));
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          _isResettingPassword
              ? Container(
                  alignment: FractionalOffset.center,
                  child: CircularProgressIndicator(),
                )
              : Container()
        ],
      ),
    );
  }
}
