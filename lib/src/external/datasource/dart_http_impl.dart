import 'dart:convert';

import 'package:a3data_challenge/src/infra/data_source/http.dart';
import 'package:http/http.dart';

class DartHttp implements Http {
  DartHttp({required this.http});

  final Client http;

  @override
  Future<dynamic> get({
    required String url,
    Map<String, String>? headers,
  }) async {
    final response = await http.get(Uri.parse(url), headers: headers);
    return jsonDecode(response.body);
  }

  @override
  Future<dynamic> post({
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
  Future<dynamic> put({
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
  Future<dynamic> delete({
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
