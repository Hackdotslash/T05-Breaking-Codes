import 'dart:convert';

import 'package:dotslash_hackathon/models/Doctor.dart';
import 'package:dotslash_hackathon/screens/home_screen.dart';
import 'package:dotslash_hackathon/utils/fetch_data.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class FetchData extends StatefulWidget {
  @override
  _FetchDataState createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var response = await FetchOnlineData().getDoctorsData();
    print(response.body);
    var input = jsonDecode(response.body);

    List<Doctor> doctors = List();

    List<dynamic> dynamicList = input['doctors'];

    dynamicList.forEach((element) {
      doctors.add(Doctor(
          name: element['name'],
          contact: element['contact'],
          address: element['address'],
          pinCode: int.parse(element['pincode']),
          specialization: element['specialization']));
    });

    var db = await openDatabase(
      'doctors.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE Doctors (id INTEGER PRIMARY KEY, name TEXT, contact INTEGER, specialization TEXT, address TEXT, pincode INTEGER)');
      },
    );

    await db.execute('DROP TABLE Doctors');

    await db.execute(
        'CREATE TABLE Doctors (id INTEGER PRIMARY KEY, name TEXT, contact INTEGER, specialization TEXT, address TEXT, pincode INTEGER)');

    doctors.forEach((element) async {
      await db.transaction((txn) async {
        await txn.rawInsert(
            'INSERT INTO Doctors(name, contact, specialization, address, pincode) values(?,?,?,?,?)',
            [
              element.name,
              element.contact,
              element.specialization,
              element.address,
              element.pinCode
            ]);
      });
    });

    List<Map> list = await db.rawQuery('SELECT * FROM Doctors');

    print(list);

    db.close();

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
