import 'dart:convert';
import 'package:dotslash_hackathon/models/Report.dart';
import 'package:dotslash_hackathon/utils/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class UploadDocuments extends StatefulWidget {
  @override
  _UploadDocumentsState createState() => _UploadDocumentsState();
}

class _UploadDocumentsState extends State<UploadDocuments> {
  bool isLoading;
  int numOfReports = 0;
  List<Report> reports = List<Report>();
  getFiles() async {
    final pref = await SharedPreferences.getInstance();
    String token = pref.getString(authToken);
    String url = homeUrl + 'get_docs';
    var response = await http.post(
      url,
      headers: {"Content-Type": "multipart/form-data", "X-Auth-Token": token},
    );
    print(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['success'] == 1) {
        print(response.body);
        jsonDecode(response.body)['docs'].forEach((e) {
          reports.add(Report(name: e['name'], url: e['link']));
          numOfReports++;
        });
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  _uploadFile() async {
    var doc = await FilePicker.getFile();
    print(doc.absolute);
    final pref = await SharedPreferences.getInstance();
    String token = pref.getString(authToken);
    String url = homeUrl + 'add_docs';
    // var response = await http.post(url, headers: {
    //   "Content-Type": "multipart/form-data",
    //   "X-Auth-Token": token
    // }, body: {
    //   "file": doc,
    //   "name": "Report " + (reports.length + 1).toString()
    // });
    var req = http.MultipartRequest('POST', Uri.parse(url))
      ..fields['name'] = "Report " + (reports.length + 1).toString()
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        doc.path
      ));
    req.headers['X-Auth-Token'] = token;
    print(req.method);
    var res = await req.send();
    if (res.statusCode == 200) {
      Fluttertoast.showToast(msg: "Upload successful");
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    getFiles();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? CircularProgressIndicator()
        : SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 50,
                      left: 20.0,
                      right: 10.0,
                      bottom: 20,
                    ),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          FlatButton(
                            child: Text(
                              'Want to upload reports? Tap here!',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(fontSize: 20),
                            ),
                            onPressed: () async {
                              _uploadFile();
                            },
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            'Your reports : ',
                            style: GoogleFonts.montserrat(fontSize: 25),
                          ),
                          if (numOfReports == 0)
                            Container(
                              child: Text(
                                'No reports added',
                                style: GoogleFonts.montserrat(fontSize: 20),
                              ),
                            )
                          else
                            ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context, i) {
                                if (numOfReports == 0) {
                                  return Container();
                                }
                                return Container(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        '${i + 1} ' + reports[i].name,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 15),
                                      ),
                                      FlatButton(
                                        child: Text(
                                          'View',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12),
                                        ),
                                        onPressed: () async {
                                          print(reports[i].url);
                                          await launch(reports[i].url);
                                        },
                                      )
                                    ],
                                  ),
                                );
                              },
                              itemCount: numOfReports,
                            ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
