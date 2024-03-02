import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_course/Controllers/mainAPI.dart';
import 'package:online_course/Models/RegistrationModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationRequest {
  Future<bool> registrationRequest(
    String first_name,
    String last_name,
    String email,
    String password,
  ) async {
    RegistrationModel user = RegistrationModel(
      first_name: first_name,
      last_name: last_name,
      email: email,
      password: password,
    );
    String mainUrl = MainApi.url;
    String registrationUrl = "$mainUrl/user-register/";
    final response = await http.post(Uri.parse(registrationUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'first_name': user.first_name,
          'last_name': user.last_name,
          'username': user.email,
          'email': user.email,
          'password': user.password,
        }));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  // Future<void> saveAuthToken(String token) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('authToken', token);
  // }
}
