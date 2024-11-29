import 'package:shared_preferences/shared_preferences.dart';

class PokemonPreferences {
  static bool _defaultIsFavourite = false;
  static String _defaultApodo = '';
  static late SharedPreferences _prefs;

  static Future<void> initShared() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool isFavourite(int id) {
    return _prefs.getBool('favorito_$id') ?? _defaultIsFavourite;
  }

  static setFavourite(int id, bool value) {
    _prefs.setBool('favorito_$id', value);
  }

  static String getApodo(int id) {
    return _prefs.getString('apodo_$id') ?? _defaultApodo;
  }

  static setApodo(int id, String value) {
    _prefs.setString('apodo_$id', value);
  }
}