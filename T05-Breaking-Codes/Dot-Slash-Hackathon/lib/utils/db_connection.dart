import 'package:dotslash_hackathon/models/User.dart';
import 'package:http/http.dart' as http;

class DBConnections {
  static const dynamic homeUrl = 'http://35.208.131.201:3000/';
  Future verifyUser(String email, String password) async {
    var url = homeUrl + 'login';
    var response = await http.post(url,
        body: {"email": email, "password": password},
        headers: {"Content-Type": "application/x-www-form-urlencoded"});

    return response;
  }

  Future registerUser(User user) async {
    var url = homeUrl + 'signup';
    var response = await http.post(url,
        body: {'email': user.email, 'password': user.password},
        headers: {"Content-Type": "application/x-www-form-urlencoded"});

    print(response.body);

    return response;
  }

  Future verifyEmail(User user) async {
    var url = homeUrl + 'verify';
    var response = await http.post(url,
        body: {'email': user.email},
        headers: {"Content-Type": "application/x-www-form-urlencoded"});

    return response;
  }

  Future resetPassword(String email) async {
    var url = homeUrl + 'forgot_pass';
    var response = await http.post(url,
        body: {'email': email},
        headers: {"Content-Type": "application/x-www-form-urlencoded"});

    return response;
  }

  Future getAuthToken(String userToken) async {
    var url = homeUrl + 'genTokenAndUserData';
    var response = http.post(url,
        body: {"token": userToken},
        headers: {"Content-Type": "application/x-www-form-urlencoded"});

    return response;
  }
}
