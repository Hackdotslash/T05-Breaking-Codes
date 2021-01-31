import 'dart:convert';
import 'package:dotslash_hackathon/models/User.dart';
import 'package:dotslash_hackathon/screens/login_screen.dart';
import 'package:dotslash_hackathon/utils/constants.dart';
import 'package:dotslash_hackathon/utils/db_connection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name;
  String _email;
  String _password;
  String _contact;
  String _age;
  String _emergencyContact;
  String _address;
  bool _isRegistering = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register Screen',
          style: kHeaderTextStyle,
        ),
        centerTitle: true,
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
                    'Register your details',
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
                                return 'Name is a required field';
                              return null;
                            },
                            onSaved: (String value) {
                              _name = value;
                            },
                            style: kTextFieldStyle,
                            decoration: InputDecoration(
                                labelText: 'Enter Name',
                                labelStyle: kTextFieldLabelStyle),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            validator: (String value) {
                              if (value.isEmpty)
                                return 'Contact is a required field';
                              return null;
                            },
                            onSaved: (String value) {
                              _contact = value;
                            },
                            style: kTextFieldStyle,
                            decoration: InputDecoration(
                                labelText: 'Enter Contact number',
                                labelStyle: kTextFieldLabelStyle),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (String value) {
                              if (value.isEmpty)
                                return 'Age is a required field';
                              return null;
                            },
                            onSaved: (String value) {
                              _age = value;
                            },
                            style: kTextFieldStyle,
                            decoration: InputDecoration(
                                labelText: 'Enter Age',
                                labelStyle: kTextFieldLabelStyle),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (String value) {
                              if (value.isEmpty)
                                return 'Emergency contact is a required field';
                              return null;
                            },
                            onSaved: (String value) {
                              _emergencyContact = value;
                            },
                            style: kTextFieldStyle,
                            decoration: InputDecoration(
                                labelText: 'Enter Emergency contact',
                                labelStyle: kTextFieldLabelStyle),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: TextFormField(
                            validator: (String value) {
                              if (value.isEmpty)
                                return 'Address is a required field';
                              return null;
                            },
                            onSaved: (String value) {
                              _address = value;
                            },
                            style: kTextFieldStyle,
                            decoration: InputDecoration(
                                labelText: 'Enter Address',
                                labelStyle: kTextFieldLabelStyle),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: TextFormField(
                            validator: (String value) {
                              if (value.isEmpty)
                                return 'Email is a required field';
                              if (!RegExp(
                                      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                  .hasMatch(value)) return 'Incorrect email';
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
                              if (!RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                  .hasMatch(value))
                                return 'Password \n 1.Should contain at least one upper case \n 2.Should contain at least one lower case \n 3.Should contain at least one digit \n 4.Should contain at least one Special character';
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
                                _isRegistering = true;
                              });
                              User user = User(
                                email: _email,
                                password: _password,
                                name: _name,
                                address: _address,
                                age: _age,
                                contact: _contact,
                                emergencyContact: _emergencyContact,
                              );
                              var resp =
                                  await DBConnections().registerUser(user);
                              if (resp.statusCode == 200) {
                                var body = jsonDecode(resp.body);
                                if (body['success'] != 0) {
                                  var resp2 =
                                      await DBConnections().verifyEmail(user);
                                  if (resp2.statusCode == 200) {
                                    var output2 = jsonDecode(resp2.body);
                                    if (output2['success'] == 1) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Verification email is sent. Please verify your email and login again");
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Verification email failed");
                                      setState(() {
                                        _isRegistering = false;
                                      });
                                    }
                                  }
                                }
                              } else {
                                setState(() {
                                  _isRegistering = false;
                                });
                                Fluttertoast.showToast(
                                    msg: "Registeration failed");
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a user?',
                      style: kNormalTextStyle,
                    ),
                    GestureDetector(
                      child: Text(
                        'Login!',
                        style: GoogleFonts.montserrat(
                            fontSize: 18, color: Colors.lightBlue),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                    )
                  ],
                ))
              ],
            ),
          ),
          _isRegistering
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
