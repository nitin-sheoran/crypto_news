import 'package:shared_preferences/shared_preferences.dart';

class DarkModePreference {
  static const String key = 'darkMode';

  static Future<void> setDarkMode(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static Future<bool> getDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }
}
