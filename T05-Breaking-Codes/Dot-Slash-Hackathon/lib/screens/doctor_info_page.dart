import 'package:dotslash_hackathon/models/Doctor.dart';
import 'package:dotslash_hackathon/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorInfo extends StatefulWidget {
  @override
  _DoctorInfoState createState() => _DoctorInfoState();
}

class _DoctorInfoState extends State<DoctorInfo> {
  List<Doctor> doctors;
  List<Doctor> suggestionsList = List();
  String query = '';
  TextEditingController searchController = TextEditingController();

  Future<List> getDoctors() async {
    List<Doctor> doctorList = List();
    List<Map> dynamicList;
    var db = await openDatabase(
      'dotslash.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE Doctors (id INTEGER PRIMARY KEY, name TEXT, contact INTEGER, specialization TEXT, address TEXT, pincode INTEGER)');
        await db.execute(
            'CREATE TABLE Events (id INTEGER PRIMARY KEY, eventTitle TEXT, location TEXT, date TEXT, time TEXT, eventDescription TEXT)');
      },
    );
    dynamicList = await db.rawQuery('SELECT * FROM Doctors');
    dynamicList.forEach((element) {
      doctorList.add(Doctor(
          name: element['name'],
          address: element['address'],
          specialization: element['specialization'],
          contact: element['contact'],
          pinCode: element['pincode']));
    });
    return doctorList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.none) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        doctors = snapshot.data;
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: searchController,
                onChanged: (val) {
                  setState(() {
                    suggestionsList = val.isEmpty
                        ? []
                        : doctors
                            .where((Doctor element) =>
                                element.pinCode == int.parse(val))
                            .toList();
                    query = val;
                  });
                },
                style: kTextFieldStyle,
                decoration: InputDecoration(
                  hintText: 'Enter a pincode',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.teal,
                    ),
                    onPressed: () {
                      WidgetsBinding.instance.addPostFrameCallback(
                          (_) => searchController.clear());
                      setState(() {
                        query = '';
                      });
                    },
                  ),
                ),
              ),
            ),
            query.isEmpty
                ? ListView.builder(
                    itemCount: doctors.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: ListTile(
                            title: Text(
                              "Doctor's name: " + doctors[index].name,
                            ),
                            subtitle: Text(
                                "Doctor's Address: " + doctors[index].address),
                            trailing: IconButton(
                              icon: Icon(Icons.phone),
                              onPressed: () async {
                                await launch('tel:+91' +
                                    doctors[index].contact.toString());
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : suggestionsList.isEmpty
                    ? Center(
                        child: Text('No doctors found'),
                      )
                    : ListView.builder(
                        itemCount: suggestionsList.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: ListTile(
                                title: Text(
                                  "Doctor's name: " +
                                      suggestionsList[index].name,
                                ),
                                subtitle: Text("Doctor's Address: " +
                                    suggestionsList[index].address),
                                trailing: IconButton(
                                  icon: Icon(Icons.phone),
                                  onPressed: () async {
                                    await launch('tel://' +
                                        suggestionsList[index]
                                            .contact
                                            .toString());
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      )
          ],
        );
      },
      future: getDoctors(),
    );
  }
}
