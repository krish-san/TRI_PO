import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart'; // Import the configuration file for base URL

class PoliceService {
  final String _baseUrl = getBaseUrl();
  Future<Map<String, dynamic>?> searchPoliceById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/police/search?id=$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Failed to search police record: ${response.statusCode}');
      }
    } catch (e) {
      print('Error searching police record: $e');
      return null;
    }
  }
}
