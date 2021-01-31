import 'dart:convert';

import 'package:dotslash_hackathon/models/Vaccine.dart';
import 'package:dotslash_hackathon/models/VaccineStatus.dart';
import 'package:dotslash_hackathon/utils/fetch_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VaccinePage extends StatefulWidget {
  @override
  _VaccinePageState createState() => _VaccinePageState();
}

class _VaccinePageState extends State<VaccinePage> {
  int length = 0;
  int reminderLength = 0;
  Future<List> getData() async {
    List<Vaccine> list = List();
    var response = await FetchOnlineData().getVaccines();
    if (response.statusCode == 200) {
      print(response.body);
      var output = jsonDecode(response.body);
      print(output['vaccines']);
      jsonDecode(response.body)['vaccines'].forEach((element) {
        // print('reached here');
        List<String> reminders = List();
        element['reminders'].forEach((e) => reminders.add(e));
        list.add(Vaccine(
          name: element['name'],
          comments: element['comments'] == null ? '' : element['comments'],
          reminders: reminders,
        ));
        print(list);
        length++;
      });
    }
    print(list);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.none) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Vaccine> vaccineList = snapshot.data;
        print(vaccineList);
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 50,
                left: 20.0,
                right: 10.0,
                bottom: 20,
              ),
              child: Container(
                child: Text(
                  'Your Vaccines: ',
                  style: GoogleFonts.montserrat(fontSize: 25),
                ),
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: vaccineList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                          title: Text(
                            "Vaccine Name: " + vaccineList[index].name,
                          ),
                          subtitle: Text(vaccineList[index].comments),
                        ),
                      ),
                      Text(
                        "Next Dates:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: vaccineList[index].reminders.length,
                        itemBuilder: (context, i) {
                          return Column(
                            children: [
                              Text(
                                vaccineList[index].reminders[i],
                                textAlign: TextAlign.center,
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        );
      },
    );
  }
}
