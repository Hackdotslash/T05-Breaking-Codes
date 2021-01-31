import 'package:dotslash_hackathon/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FetchOnlineData {
  Future getDoctorsData() async {
    final pref = await SharedPreferences.getInstance();
    String token = pref.getString(authToken);
    String url = homeUrl + 'getDoctors';
    var response = await http.post(url, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "X-Auth-Token": token
    });
    return response;
  }

  Future getEventsData() async {
    final pref = await SharedPreferences.getInstance();
    String token = pref.getString(authToken);
    String url = homeUrl + 'get_events';
    var response = await http.post(url, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "X-Auth-Token": token
    });
    return response;
  }

  Future getReports() async{
    final pref = await SharedPreferences.getInstance();
    String token = pref.getString(authToken);
    String url = homeUrl + 'get_events';
    var response = await http.post(url, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "X-Auth-Token": token
    });
    return response;
  }

  Future getVaccines() async{
    final pref = await SharedPreferences.getInstance();
    String token = pref.getString(authToken);
    String url = homeUrl + 'get_vaccines';
    var response = await http.post(url, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "X-Auth-Token": token
    });
    return response;
  }
}
