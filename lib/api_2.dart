import 'dart:convert';

import 'package:api/Activity.dart';
import 'package:http/http.dart' as http;

class ApiService {
  String baseUrl = "https://bored-api.appbrewery.com/random";

  Future<Activity> getActivity() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return Activity.fromJson(jsonResponse);
    } else {
      throw Exception('Error HTTP ${response.statusCode}');
    }
  }
}
