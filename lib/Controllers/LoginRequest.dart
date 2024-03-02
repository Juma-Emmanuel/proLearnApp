import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_course/Controllers/mainAPI.dart';
import 'package:online_course/Models/LoginModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef AuthCallback = void Function(bool isAuthenticated);

class LoginRequest {
  AuthCallback? onAuthentication;
  Future loginRequest(
    String email,
    String password,
  ) async {
    LoginModel user = LoginModel(
      email: email,
      password: password,
    );
    String mainUrl = MainApi.url;
    String registrationUrl = "$mainUrl/authenticate/";
    final response = await http.post(Uri.parse(registrationUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': user.email,
          'password': user.password,
        }));
    final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      if (responseData.containsKey('access')) {
        await saveAuthToken(responseData['access']);
      }
      if (onAuthentication != null) {
        onAuthentication!(true);
      }
    } else {
      if (onAuthentication != null) {
        onAuthentication!(false);
      }
    }
  }

  Future<void> saveAuthToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwtToken', token);
    print('hello');
    print(token);
  }
}
