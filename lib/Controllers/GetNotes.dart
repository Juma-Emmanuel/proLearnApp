import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_course/Controllers/mainAPI.dart';
import 'package:online_course/Models/Note.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class GetNotes {
  Future<List<Note>> fetchNotes(int noteId) async {
    String mainUrl = MainApi.url;
    String fetchUrl = "$mainUrl/courses/$noteId/notes";
    try {
      final response = await http.get(
        Uri.parse(fetchUrl),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);

        List<Note> courses =
            jsonList.map((json) => Note.fromJson(json)).toList();

        return courses;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
