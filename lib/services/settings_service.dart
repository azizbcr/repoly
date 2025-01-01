import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const String _viewModeKey = 'viewMode';
  static const String _tempUnitKey = 'tempUnit';
  static const String _languageKey = 'language';
  static const String _notificationsKey = 'notifications';

  // Varsayılan değerler
  static const String defaultViewMode = 'Liste';
  static const String defaultTempUnit = '°C';
  static const String defaultLanguage = 'Türkçe';
  static const bool defaultNotifications = true;

  // Ayarları yükle
  static Future<Map<String, dynamic>> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'viewMode': prefs.getString(_viewModeKey) ?? defaultViewMode,
      'tempUnit': prefs.getString(_tempUnitKey) ?? defaultTempUnit,
      'language': prefs.getString(_languageKey) ?? defaultLanguage,
      'notifications': prefs.getBool(_notificationsKey) ?? defaultNotifications,
    };
  }

  // Ayarları kaydet
  static Future<void> saveSetting(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    switch (key) {
      case _viewModeKey:
      case _tempUnitKey:
      case _languageKey:
        await prefs.setString(key, value as String);
        break;
      case _notificationsKey:
        await prefs.setBool(key, value as bool);
        break;
    }
  }
}
