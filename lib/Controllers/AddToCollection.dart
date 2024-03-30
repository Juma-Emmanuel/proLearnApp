import 'package:http/http.dart' as http;
import 'package:online_course/Controllers/Authorize.dart';
import 'package:online_course/Controllers/mainAPI.dart';

class AddToCollection {
  final AuthorizeRequest _authorizeRequest = AuthorizeRequest();

  Future<String> addToCollectionRequest(int courseId) async {
    String? token = await _authorizeRequest.authorizeRequest();
    if (token == null) {
      throw Exception('Token is null');
    }
    String mainUrl = MainApi.url;
    String registrationUrl = "$mainUrl/add-to-collection/$courseId/";
    final response = await http.post(
      Uri.parse(registrationUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 201) {
      return 'success';
    } else if (response.statusCode == 400) {
      print(response.statusCode);
      return 'bad_request';
    } else {
      return 'error';
    }
  }
}
