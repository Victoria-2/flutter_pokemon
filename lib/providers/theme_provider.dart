import 'package:flutter/material.dart';
import 'package:flutter_pokemon/helpers/preferences.dart';

class ThemeProvider with ChangeNotifier {
  // Inicializa el tema basado en las preferencias almacenadas
  ThemeProvider() {
    _isDarkMode = Preferences.isDarkMode;
  }

  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    Preferences.isDarkMode = _isDarkMode; // Guarda el estado en SharedPreferences
    notifyListeners(); // Notifica a los widgets que usan este provider
  }

  ThemeData get currentTheme =>
      _isDarkMode ? ThemeData.dark() : ThemeData.light();
}