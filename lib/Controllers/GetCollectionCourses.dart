import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_course/Controllers/Authorize.dart';
import 'package:online_course/Controllers/mainAPI.dart';
import 'package:online_course/Models/Course.dart';

class GetCollectionCourses {
  final AuthorizeRequest _authorizeRequest = AuthorizeRequest();

  Future<List<Course>> fetchCourses() async {
    String? token = await _authorizeRequest.authorizeRequest();
    if (token == null) {
      throw Exception('Token is null');
    }

    String mainUrl = MainApi.url;
    String fetchUrl = "$mainUrl/collectioncourses/";
    try {
      final response = await http.get(
        Uri.parse(fetchUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
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
