import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static bool _isDarkMode = false;

  // Inicializa las preferencias
  static Future<void> initShared() async {
    _prefs = await SharedPreferences.getInstance();
    _isDarkMode = _prefs.getBool('isDarkMode') ?? false;
  }

  // Obtiene el valor de DarkMode
  static bool get isDarkMode => _isDarkMode;

  // Establece el valor de DarkMode
  static set isDarkMode(bool value) {
    _isDarkMode = value;
    _prefs.setBool('isDarkMode', value);
  }
}