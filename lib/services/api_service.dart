import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // ⚠️ IMPORTANT: Change this to your computer's local IP address
  // (not "localhost") if testing on a real Android phone.
  // Find your IP using `ipconfig` (Windows) -> look for "IPv4 Address".
  // Example: 'http://192.168.1.5/stay-secure-backend'
  static const String baseUrl = 'http://localhost/stay-secure-backend';
  // 10.0.2.2 = special address that points to your PC's localhost
  // FROM the Android emulator only. For Chrome testing, use 'http://localhost/stay-secure-backend'.
  // For a real phone, use your PC's actual WiFi IP address instead.

  static Future<Map<String, dynamic>> register(
      String name, String email, String phone, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register.php'),
        body: {
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
        },
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Connection error: $e'};
    }
  }

  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login.php'),
        body: {
          'email': email,
          'password': password,
        },
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Connection error: $e'};
    }
  }

  static Future<Map<String, dynamic>> getContacts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/get_contacts.php'));
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'contacts': []};
    }
  }

  static Future<Map<String, dynamic>> addContact(
      String name, String phone) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/add_contact.php'),
        body: {'name': name, 'phone': phone},
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Connection error: $e'};
    }
  }

  static Future<Map<String, dynamic>> sendSosAlert(
      double lat, double lng) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/sos_alert.php'),
        body: {'latitude': lat.toString(), 'longitude': lng.toString()},
      );
      return jsonDecode(response.body);
    } catch (e) {
      return {'success': false, 'message': 'Connection error: $e'};
    }
  }
}
