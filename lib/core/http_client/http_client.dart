import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class HttpClient {
  Future<List<dynamic>> get(String url);
}

class HttpClientImpl implements HttpClient {
  final client = http.Client();

  @override
  Future<List<dynamic>> get(String url) async {
    try {
      final response = await client.get(Uri.parse(url));

      final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));

      return decodedResponse;
    } catch (e) {
      throw Exception('Failed to make GET request: $e');
    }
  }
}
