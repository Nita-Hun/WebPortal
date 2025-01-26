import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_portal/models/test_model.dart';
import 'package:web_portal/utils/constains.dart';


class TestService {
  final String baseUrl;

  TestService({this.baseUrl = apiBaseUrl});

  /// Fetch all tests
  Future<List<Test>> fetchTests() async {
    final url = Uri.parse('$baseUrl/tests');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Test.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch tests: ${response.reasonPhrase}');
    }
  }

  /// Fetch test by ID
  Future<Test> fetchTestById(int testId) async {
    final url = Uri.parse('$baseUrl/tests/$testId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Test.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch test: ${response.reasonPhrase}');
    }
  }

  /// Submit test answers
  Future<void> submitTest(int testId, Map<String, dynamic> answers) async {
    final url = Uri.parse('$baseUrl/tests/$testId/submit');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'answers': answers}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to submit test: ${response.reasonPhrase}');
    }
  }
  Future<Test> saveQuestion(Test test) async {
    final url = Uri.parse('$baseUrl/questions');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(test.toJson());
    final response = await http.post(url, headers: headers, body: body);

    if(response.statusCode == 201) {
      return Test.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to save question: ${response.reasonPhrase}');
      
  }
}
}

