import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_course/Controllers/mainAPI.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthorizeRequest {
  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('refreshToken');
  }

  Future<String?> authorizeRequest() async {
    String? token = await getAuthToken();
    if (token == null) {
      throw Exception('Token is null');
    }
    String mainUrl = MainApi.url;
    String registrationUrl = "$mainUrl/auth-refresh/";
    final response = await http.post(Uri.parse(registrationUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'refresh': token,
        }));
    final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      if (responseData.containsKey('access')) {
        await saveAuthToken(
          responseData['access'],
        );
        return responseData['access'];
      } else {
        throw Exception('Access token not found in response');
      }
    } else {
      throw Exception('Failed to refresh token');
    }
  }

  Future<void> saveAuthToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwtToken', token);

    print('hello its working');
    print(token);
  }
}
