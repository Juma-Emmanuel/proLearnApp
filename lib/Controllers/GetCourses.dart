import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_course/Controllers/mainAPI.dart';
import 'package:online_course/Models/Course.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class GetCourses {
  Future<List<Course>> fetchCourses() async {
    String mainUrl = MainApi.url;
    String fetchUrl = "$mainUrl/courses/";
    try {
      final response = await http.get(
        Uri.parse(fetchUrl),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);

        List<Course> courses =
            jsonList.map((json) => Course.fromJson(json)).toList();

        return courses;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
