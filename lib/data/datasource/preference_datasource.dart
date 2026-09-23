import 'package:shared_preferences/shared_preferences.dart';

class PreferenceDataSource {
  static const String _keyUserName = 'user_name';
  static const String _keyCurrency = 'currency';

  Future<void> saveSettings(String name, String currency) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserName, name);
    await prefs.setString(_keyCurrency, currency);
  }

  Future<Map<String, String>> getSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString(_keyUserName) ?? 'Urmat',
      'currency': prefs.getString(_keyCurrency) ?? 'сом',
    };
  }
}
