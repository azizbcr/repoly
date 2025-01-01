import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = true;
  final String _themeKey = 'isDarkMode';

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(_themeKey) ?? true;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, _isDarkMode);
    notifyListeners();
  }

  ThemeData get themeData {
    if (_isDarkMode) {
      return ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
          onPrimary: Colors.white,
          secondary: Colors.white,
          surface: Colors.black,
          background: Colors.black,
          onBackground: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.black,
          elevation: 0,
          margin: EdgeInsets.zero,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
        ),
        textTheme: const TextTheme().apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        dividerTheme: DividerThemeData(
          color: Colors.grey.shade800,
          thickness: 0.5,
        ),
      );
    } else {
      return ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme.light(
          primary: Colors.black,
          onPrimary: Colors.black,
          secondary: Colors.black,
          surface: Colors.white,
          background: Colors.white,
          onBackground: Colors.black,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          margin: EdgeInsets.zero,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
        ),
        textTheme: const TextTheme().apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        dividerTheme: DividerThemeData(
          color: Colors.grey.shade200,
          thickness: 0.5,
        ),
      );
    }
  }
}
