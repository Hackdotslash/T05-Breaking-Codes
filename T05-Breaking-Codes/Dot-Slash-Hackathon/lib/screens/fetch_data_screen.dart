import 'dart:convert';

import 'package:dotslash_hackathon/models/Doctor.dart';
import 'package:dotslash_hackathon/models/Event.dart';
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

  addEvents(List<Event> events) async{
    var db = await openDatabase('dotslash.db');
    events.forEach((element) async {
      await db.transaction((txn) async {
        await txn.rawInsert(
            'INSERT INTO Events(eventTitle, location, date, time, eventDescription, hostDoctor) values(?,?,?,?,?,?)',
            [
              element.eventTitle,
              element.location,
              element.date,
              element.time,
              element.eventDescription,
              element.hostDoctor
            ]);
      });
    });
  }

  addDoctors(List<Doctor> doctors) async {
    doctors.forEach((element) async {
      var db = await openDatabase('dotslash.db');
      await db.transaction((txn) async {
        await txn.rawInsert(
            'INSERT INTO Doctors(name, contact, specialization, address, pincode,uid) values(?,?,?,?,?,?)',
            [
              element.name,
              element.contact,
              element.specialization,
              element.address,
              element.pinCode,
              element.uid
            ]);
      });
    });
  }

  fetchData() async {
    var response = await FetchOnlineData().getDoctorsData();
    // print(response.body);
    var input = jsonDecode(response.body);

    List<Doctor> doctors = List();

    List<dynamic> dynamicList = input['doctors'];

    var response2 = await FetchOnlineData().getEventsData();
    // print(response2.body);
    var input2 = jsonDecode(response2.body);

    List<Event> events = List();

    List<dynamic> dynamicList2 = input2['events'];

    print(dynamicList);

    dynamicList.forEach((element) {
      if(element['name'] != null)
      doctors.add(Doctor(
          name: element['name'],
          contact: element['contact'],
          address: element['address'],
          pinCode: int.parse(element['pincode']),
          specialization: element['specialization']));
    });

    dynamicList2.forEach((element) {
      events.add(Event(
          date: element['date'],
          eventDescription: element['description'],
          eventTitle: element['title'],
          hostDoctor: element['doc_details'],
          location: element['location'],
          time: element['time']));
    });

    var db = await openDatabase(
      'dotslash.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE Doctors (id INTEGER PRIMARY KEY, name TEXT, contact INTEGER, specialization TEXT, address TEXT, pincode INTEGER, uid TEXT)');
        await db.execute(
            'CREATE TABLE Events (id INTEGER PRIMARY KEY, eventTitle TEXT, location TEXT, date TEXT, time TEXT, eventDescription TEXT, hostDoctor TEXT)');
      },
    );

    await db.execute('DROP TABLE Doctors');
    await db.execute('DROP TABLE Events');

    await db.execute(
        'CREATE TABLE Doctors (id INTEGER PRIMARY KEY, name TEXT, contact INTEGER, specialization TEXT, address TEXT, pincode INTEGER, uid TEXT)');
    await db.execute(
        'CREATE TABLE Events (id INTEGER PRIMARY KEY, eventTitle TEXT, location TEXT, date TEXT, time TEXT, eventDescription TEXT, hostDoctor TEXT)');

    addDoctors(doctors);

    addEvents(events);

    // List<Map> list = await db.rawQuery('SELECT * FROM Doctors');

    // print(list);

    // list = await db.rawQuery('SELECT * FROM Events');

    // print(list);

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
