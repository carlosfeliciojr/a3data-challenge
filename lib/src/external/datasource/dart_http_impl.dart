import 'dart:convert';

import 'package:a3data_challenge/src/infra/data_source/http.dart';
import 'package:http/http.dart' as http;

class DartHttp implements Http {
  @override
  Future<Map<String, dynamic>> get({
    required String url,
    Map<String, String>? headers,
  }) async {
    final response = await http.get(Uri.parse(url), headers: headers);
    return jsonDecode(response.body);
  }

  @override
  Future<Map<String, dynamic>> post({
    required String url,
    required dynamic data,
    Map<String, String>? headers,
  }) async {
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );
    return jsonDecode(response.body);
  }

  @override
  Future<Map<String, dynamic>> put({
    required String url,
    required dynamic data,
    Map<String, String>? headers,
  }) async {
    final response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );
    return jsonDecode(response.body);
  }

  @override
  Future<Map<String, dynamic>> delete({
    required String url,
    Map<String, String>? headers,
  }) async {
    final response = await http.delete(
      Uri.parse(url),
      headers: headers,
    );
    return jsonDecode(response.body);
  }
}
