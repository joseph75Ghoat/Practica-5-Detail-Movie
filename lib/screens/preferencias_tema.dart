import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkTheme = false;
  static const String themeKey = 'theme_key';

  bool get isDarkTheme => _isDarkTheme;

  ThemeProvider() {
    _loadTheme();
  }

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    _saveTheme();
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool(themeKey) ?? false;
    notifyListeners();
  }

  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(themeKey, _isDarkTheme);
  }
}
