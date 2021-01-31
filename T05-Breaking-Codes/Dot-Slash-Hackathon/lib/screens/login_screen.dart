import 'dart:convert';
import 'package:dotslash_hackathon/screens/fetch_data_screen.dart';
import 'package:dotslash_hackathon/screens/forgot_password.dart';
import 'package:dotslash_hackathon/screens/register_screen.dart';
import 'package:dotslash_hackathon/utils/constants.dart';
import 'package:dotslash_hackathon/utils/db_connection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _email;
  String _password;
  bool _isLoggingIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
<<<<<<< HEAD
          'Login',
=======
          'Login Screen',
>>>>>>> 3ada0ad7e2399a554aedc1ff45a46c8336207e67
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
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: TextFormField(
                            validator: (String value) {
                              if (value.isEmpty)
                                return 'Password is a required field';
                              return null;
                            },
                            onSaved: (String value) {
                              _password = value;
                            },
                            style: kTextFieldStyle,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Enter password',
                              labelStyle: kTextFieldLabelStyle,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: RaisedButton(
                            child: Text(
                              'Submit',
                              style: kButtonTextStyle,
                            ),
                            color: kButtonColor,
                            onPressed: () async {
                              if (!_formKey.currentState.validate()) return;
                              _formKey.currentState.save();
                              setState(() {
                                _isLoggingIn = true;
                              });
                              var resp = await DBConnections()
                                  .verifyUser(_email, _password);

                              if (resp.statusCode == 200) {
                                print(resp.body);
                                dynamic output = jsonDecode(resp.body);
                                if (output['success'] == -10) {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Email not verified. Please verify your email and login again");
                                  setState(() {
                                    _isLoggingIn = false;
                                  });
                                } else {
                                  Fluttertoast.showToast(msg: "Login Success");
                                  setState(() {
                                    _isLoggingIn = false;
                                  });
                                  var tokenResponse = await DBConnections()
                                      .getAuthToken(output['token']);

                                  print(tokenResponse.body);

                                  if (tokenResponse.statusCode == 200) {
                                    final pref =
                                        await SharedPreferences.getInstance();
                                    var output2 =
                                        jsonDecode(tokenResponse.body);
                                    await pref.setString(
                                        authToken, output2['token']);

                                    print(output2['user']['userId']);

                                    await pref.setString(
                                        uid, output2['user']['userId']);

                                    List<String> doctors = List();

                                    output2['user']['doctors'].forEach((e) => doctors.add(e));

                                    await pref.setStringList(doctorsList, doctors);

                                    await pref.setString(emergencyContact, output2['user']['emergencyContact'].toString());

                                    await pref.setString(
                                        kStatusText, "Logged in");
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => FetchData()));
                                  }
                                }
                              } else {
                                setState(() {
                                  _isLoggingIn = false;
                                });
                                Fluttertoast.showToast(msg: "Login Failed");
                              }
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
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Forgot Password?',
                                    style: kNormalTextStyle,
                                  ),
                                  GestureDetector(
                                    child: Text(
                                      ' Reset it!',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          color: Colors.lightBlue),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ForgotPassword()));
                                    },
                                  )
                                ],
                              ),
                              Row(
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
                                          fontSize: 18,
                                          color: Colors.lightBlue),
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
          _isLoggingIn
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
