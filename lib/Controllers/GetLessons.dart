import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_course/Controllers/mainAPI.dart';

import 'package:online_course/Models/Lesson.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class GetLessons {
  Future<List<Lesson>> fetchLessons(int courseId) async {
    String mainUrl = MainApi.url;
    String fetchUrl = "$mainUrl/lessons/$courseId/";
    try {
      final response = await http.get(
        Uri.parse(fetchUrl),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);

        List<Lesson> lessons =
            jsonList.map((json) => Lesson.fromJson(json)).toList();

        return lessons;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
