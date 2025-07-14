import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart'; // Import the configuration file for base URL

class AccusedService {
  final String _baseUrl = getBaseUrl();
  Future<Map<String, dynamic>?> searchAccusedById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/accused/search?id=$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to search accused: ${response.statusCode}');
      }
    } catch (e) {
      print('Error searching accused: $e');
      return null;
    }
  }
}