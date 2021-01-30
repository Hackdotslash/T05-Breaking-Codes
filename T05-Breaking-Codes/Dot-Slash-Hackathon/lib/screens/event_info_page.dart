import 'package:dotslash_hackathon/models/Event.dart';
import 'package:dotslash_hackathon/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:easy_localization/easy_localization.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  List<Event> events = List();
  List<Event> suggestionsList = List();
  String query = '';
  TextEditingController searchController = TextEditingController();

  Future<List> getEventDetails() async {
    List<Event> eventList = List();
    List<Map> dynamicList;
    var db = await openDatabase(
      'dotslash.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE Doctors (id INTEGER PRIMARY KEY, name TEXT, contact INTEGER, specialization TEXT, address TEXT, pincode INTEGER)');
        await db.execute(
            'CREATE TABLE Events (id INTEGER PRIMARY KEY, eventTitle TEXT, location TEXT, date TEXT, time TEXT, eventDescription TEXT, hostDoctor TEXT)');
      },
    );
    dynamicList = await db.rawQuery('SELECT * FROM Events');
    print(dynamicList);
    dynamicList.forEach((element) {
      eventList.add(Event(
          date: element['date'],
          eventDescription: element['eventDescription'],
          eventTitle: element['eventTitle'],
          hostDoctor: element['hostDoctor'],
          location: element['location'],
          time: element['time']));
    });
    db.close();
    return eventList;
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
        events = snapshot.data;
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: searchController,
                onChanged: (val) {
                  setState(() {
                    suggestionsList = val.isEmpty
                        ? []
                        : events
                            .where((Event element) => element.eventTitle
                                .toLowerCase()
                                .contains(val.toLowerCase()))
                            .toList();
                    query = val;
                  });
                },
                style: kTextFieldStyle,
                decoration: InputDecoration(
                  hintText: 'Enter event name',
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
                    itemCount: events.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: ListTile(
                            title: Row(
                              children: [
                                Text(
                                  "eventName",
                                ).tr(),
                                Text(events[index].eventTitle)
                              ],
                            ),
                            subtitle: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "eventDescription",
                                      textAlign: TextAlign.left,
                                    ).tr(),
                                    Flexible(
                                      fit: FlexFit.loose,
                                      child: Text(
                                        events[index].eventDescription,
                                        textAlign: TextAlign.left,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "hostDoctor",
                                      textAlign: TextAlign.left,
                                    ).tr(),
                                    Text(
                                      events[index].hostDoctor,
                                      textAlign: TextAlign.left,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.date_range),
                                    Text(events[index].date)
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.timer),
                                    Text(events[index].time)
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_on),
                                    Text(events[index].location)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : suggestionsList.isEmpty
                    ? Center(
                        child: Text('No events found'),
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
                                title: Row(
                                  children: [
                                    Text("eventName").tr(),
                                    Text(
                                      suggestionsList[index].eventTitle,
                                    )
                                  ],
                                ),
                                subtitle: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "eventDescription",
                                          textAlign: TextAlign.left,
                                        ).tr(),
                                        Text(
                                          suggestionsList[index]
                                              .eventDescription,
                                          textAlign: TextAlign.left,
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "hostDoctor",
                                          textAlign: TextAlign.left,
                                        ).tr(),
                                        Text(suggestionsList[index].hostDoctor,
                                            textAlign: TextAlign.left)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.date_range),
                                        Text(suggestionsList[index].date)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.timer),
                                        Text(suggestionsList[index].time)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on),
                                        Text(suggestionsList[index].location)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
          ],
        );
      },
      future: getEventDetails(),
    );
  }
}
