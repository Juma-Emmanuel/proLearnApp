import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_course/Controllers/mainAPI.dart';
import 'package:online_course/Models/Category.dart';
import 'package:online_course/Models/User.dart';

import 'package:shared_preferences/shared_preferences.dart';

class GetUser {
  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwtToken');
  }

  Future<User> fetchUser() async {
    String? token = await getAuthToken();
    print(token);
    if (token == null) {
      throw Exception('Token is null');
    }
    String mainUrl = MainApi.url;
    String fetchUrl = "$mainUrl/current-user/";
    try {
      final response = await http.get(
        Uri.parse(fetchUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> userData = json.decode(response.body);

        print(User.fromJson(userData));

        return User.fromJson(userData);
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during fetch request: $e');
    }
  }
}
