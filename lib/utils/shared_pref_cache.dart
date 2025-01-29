import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesCache {
  static const _cacheKey = 'graphql_cache';

  Future<void> saveCache(Map<String, dynamic> cacheData) async {
    final prefs = await SharedPreferences.getInstance();
    String encodedCache = jsonEncode(cacheData);
    await prefs.setString(_cacheKey, encodedCache);
  }

  Future<Map<String, dynamic>?> getCache() async {
    final prefs = await SharedPreferences.getInstance();
    String? encodedCache = prefs.getString(_cacheKey);

    if (encodedCache != null) {
      return Map<String, dynamic>.from(jsonDecode(encodedCache));
    }
    return null;
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheKey);
  }
}
