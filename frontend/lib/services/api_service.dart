import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // 🔴 PRIMARY BACKEND URL (Render)
  static const String baseUrl =
      "https://smart-complaint-system-app-1.onrender.com/api";

  // ==========================
  // GET ALL COMPLAINTS
  // ==========================
  static Future<List<dynamic>> getComplaints() async {
    final response = await http.get(Uri.parse("$baseUrl/complaints/"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to fetch complaints");
    }
  }

  // ==========================
  // ADD COMPLAINT
  // ==========================
  static Future<bool> addComplaint(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse("$baseUrl/add/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
    return response.statusCode == 201 || response.statusCode == 200;
  }

  // ==========================
  // UPDATE STATUS (Resolve)
  // ==========================
  static Future<bool> updateStatus(int id, String status) async {
    final response = await http.patch(
      Uri.parse("$baseUrl/complaints/$id/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"status": status}),
    );
    return response.statusCode == 200;
  }
}
