import 'dart:convert';  // For JSON encoding
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_5/server/backend_url.dart';


class RegisterController {

  Future<Map<String, dynamic>?> register(String name, String email, String password, String fcmToken) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var request = http.MultipartRequest('POST', BackendURl.register);

      request.fields['name'] = name;
      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['fcm_token'] = fcmToken;

      var response = await request.send();

      var responseData = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(responseData.body);
        await prefs.setString('token', map['data']['access_token']);
        return map;
      } else {

        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

class LoginController {
  Future<Map<String, dynamic>?> login(String email, String password, String fcmToken) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();


      var response = await http.post(BackendURl.login,
      body: {
        'email': email,
        'password': password,
        'fcm_token': fcmToken
      }
      );

      if (response.statusCode == 200) {
          Map<String, dynamic> map = jsonDecode(response.body);
            await prefs.setString('token', map['data']['access_token']);
          return map;

      } else {
        return null;
      }
    } catch (e) {

      return null;
    }
  }
  Future<bool> logout() async {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final response = await http.post(
          BackendURl.logout,
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${prefs.getString('token')}'
          },
        );

        if (response.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      } catch (e) {
        return false;
    }

  }

}