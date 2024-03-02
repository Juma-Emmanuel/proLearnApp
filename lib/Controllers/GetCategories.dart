import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_course/Controllers/mainAPI.dart';
import 'package:online_course/Models/Category.dart';

// import 'package:shared_preferences/shared_preferences.dart';

class GetCategories {
  Future<List<Category>> fetchCategories() async {
    String mainUrl = MainApi.url;
    String fetchUrl = "$mainUrl/categories/";
    try {
      final response = await http.get(
        Uri.parse(fetchUrl),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);

        List<Category> categories =
            jsonList.map((json) => Category.fromJson(json)).toList();

        return categories;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
