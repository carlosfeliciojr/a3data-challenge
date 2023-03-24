import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:a3data_challenge/src/infra/drivers/database.dart';

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
  Future<dynamic> getItem({required String key}) async {
    final jsonString = sharedPreferences.getString(key);
    return jsonString != null ? jsonDecode(jsonString) : null;
  }

  @override
  Future<bool> setItem({
    required String key,
    required dynamic data,
  }) async {
    final jsonString = jsonEncode(data);
    return await sharedPreferences.setString(key, jsonString);
  }

  @override
  Future<bool> removeItem({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  @override
  Future<bool> clear() async {
    return await sharedPreferences.clear();
  }
}
