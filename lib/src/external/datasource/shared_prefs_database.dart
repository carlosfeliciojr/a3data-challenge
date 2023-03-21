import 'dart:convert';

import 'package:a3data_challenge/src/infra/data_source/local_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsDatabase implements LocalDatabase {
  SharedPreferences? _prefs;

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<Map<String, dynamic>?> getItem({required String key}) async {
    final jsonString = _prefs?.getString(key);
    return jsonString != null ? jsonDecode(jsonString) : null;
  }

  @override
  Future<void> setItem({
    required String key,
    required Map<String, dynamic> data,
  }) async {
    final jsonString = jsonEncode(data);
    await _prefs?.setString(key, jsonString);
  }

  @override
  Future<void> removeItem({required String key}) async {
    await _prefs?.remove(key);
  }

  @override
  Future<void> clear() async {
    await _prefs?.clear();
  }
}
