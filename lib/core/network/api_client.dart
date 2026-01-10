import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:jolly_podcast/core/constants/utils.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final String baseUrl = dotenv.env['BASE_URL']!;
  final appSecureStorage = AppSecureStorage();

  // * Post method
  Future<http.Response> post({
    required String endpoint,
    Map<String, dynamic>? body,
  }) async {
    try {
      final accessToken = await appSecureStorage.getToken();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');

      if (accessToken == null || userId == null) {
        debugPrint('Token or user ID is null');
        final response = http.Response(
          'Unauthorised, no token or user ID found',
          500,
          headers: {'Content-Type': 'application/json'},
        );
        return response;
      }

      final url = Uri.parse('$baseUrl/$endpoint');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      debugPrint('POST error: ${e.toString()}');
      final response = http.Response(
        jsonEncode({
          'error': 'An error occured while processing your request',
          'details': e.toString(),
        }),
        500,
        headers: {'Content-Type': 'application/json'},
      );
      return response;
    }
  }

  // * Auth post
  Future<http.Response> authPost({
    required String endpoint,
    Map<String, dynamic>? body,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/$endpoint');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      debugPrint('AUTH POST error: ${e.toString()}');
      final response = http.Response(
        jsonEncode({
          'error': 'An error occured while processing your request',
          'details': e.toString(),
        }),
        500,
        headers: {'Content-Type': 'application/json'},
      );
      return response;
    }
  }

  // * Get method
  Future<http.Response> get({required String endpoint}) async {
    try {
      final accessToken = await appSecureStorage.getToken();
      final url = Uri.parse('$baseUrl/$endpoint');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      return response;
    } catch (e) {
      debugPrint('GET error: ${e.toString()}');
      final response = http.Response(
        jsonEncode({
          'error': 'An unknown error occured processing your request',
          'details': e.toString(),
        }),
        500,
        headers: {'Content-Type': 'application/json'},
      );
      return response;
    }
  }
}
