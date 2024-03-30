import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_course/Controllers/Authorize.dart';
import 'package:online_course/Controllers/mainAPI.dart';
import 'package:online_course/Models/report.dart';

class GetReport {
  final AuthorizeRequest _authorizeRequest = AuthorizeRequest();

  late Report report;
  late Future<Report> userFuture;

  Future<Report> fetchReport() async {
    String? token = await _authorizeRequest.authorizeRequest();
    if (token == null) {
      throw Exception('Token is null');
    }

    String mainUrl = MainApi.url;
    String fetchUrl = "$mainUrl/report/";

    try {
      final response = await http.get(
        Uri.parse(fetchUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        return Report.fromJson(responseData);
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during fetch request: $e');
    }
  }
}
