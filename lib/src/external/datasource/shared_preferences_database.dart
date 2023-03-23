import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:a3data_challenge/src/infra/data_source/database.dart';

class SharedPreferencesDatabase implements Database {
  SharedPreferencesDatabase({
    required this.sharedPreferences,
  });

  SharedPreferences sharedPreferences;

  @override
  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Future<Map<String, dynamic>?> getItem({required String key}) async {
    final jsonString = sharedPreferences.getString(key);
    return jsonString != null ? jsonDecode(jsonString) : null;
  }

  @override
  Future<void> setItem({
    required String key,
    required dynamic data,
  }) async {
    final jsonString = jsonEncode(data);
    await sharedPreferences.setString(key, jsonString);
  }

  @override
  Future<void> removeItem({required String key}) async {
    await sharedPreferences.remove(key);
  }

  @override
  Future<void> clear() async {
    await sharedPreferences.clear();
  }
}
