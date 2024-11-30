import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static bool _isDarkMode = false;

  // Inicializa SharedPreferences y asigna el valor predeterminado de dark mode
  static Future<void> initShared() async {
    _prefs = await SharedPreferences.getInstance();
    _isDarkMode = _prefs.getBool('isDarkMode') ?? false; // Carga el valor
  }

  static bool get isDarkMode => _isDarkMode;

  static set isDarkMode(bool value) {
    _isDarkMode = value;
    _prefs.setBool('isDarkMode', value); // Guarda el valor en SharedPreferences
  }
}