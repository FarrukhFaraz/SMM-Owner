import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static SharedPreferences? _prefs;

  // Initialize SharedPreferences (Call this in main.dart before using)
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Ensure SharedPreferences is initialized
  static void _checkInit() {
    if (_prefs == null) {
      throw Exception("SharedPreferences has not been initialized. Call SharedPreferenceService.init() in main.dart before using.");
    }
  }

  // Save a String value
  static Future<void> setString(String key, String value) async {
    _checkInit();
    await _prefs!.setString(key, value);
  }

  // Get a String value
  static String? getString(String key) {
    _checkInit();
    return _prefs!.getString(key);
  }

  // Save an int value
  static Future<void> setInt(String key, int value) async {
    _checkInit();
    await _prefs!.setInt(key, value);
  }

  // Get an int value
  static int? getInt(String key) {
    _checkInit();
    return _prefs!.getInt(key);
  }

  // Save a double value
  static Future<void> setDouble(String key, double value) async {
    _checkInit();
    await _prefs!.setDouble(key, value);
  }

  // Get a double value
  static double? getDouble(String key) {
    _checkInit();
    return _prefs!.getDouble(key);
  }

  // Save a bool value
  static Future<void> setBool(String key, bool value) async {
    _checkInit();
    await _prefs!.setBool(key, value);
  }

  // Get a bool value
  static bool? getBool(String key) {
    _checkInit();
    return _prefs!.getBool(key);
  }

  // Save a List<String> value
  static Future<void> setStringList(String key, List<String> value) async {
    _checkInit();
    await _prefs!.setStringList(key, value);
  }

  // Get a List<String> value
  static List<String>? getStringList(String key) {
    _checkInit();
    return _prefs!.getStringList(key);
  }

  // Remove a specific key
  static Future<void> remove(String key) async {
    _checkInit();
    await _prefs!.remove(key);
  }

  // Clear all preferences
  static Future<void> clear() async {
    _checkInit();
    await _prefs!.clear();
  }
}
