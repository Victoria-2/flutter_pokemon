import 'package:flutter_pokemon/providers/pokemon_provider.dart';
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
  
static List<List<dynamic>> getAllFavouritePokemon(PokemonProvider pokemonProvider) {
  final keys = _prefs.getKeys();  // Obtener todas las claves
  List<List<dynamic>> favouritePokemonDetails = [];

  for (String key in keys) {
    // Verificamos si la clave corresponde a un Pokémon favorito
    if (key.startsWith('favorito_')) {
      final id = int.tryParse(key.split('_')[1] ?? '');  // Extrae el ID
      if (id != null && isFavourite(id)) {
        // Buscar el Pokémon con el ID correspondiente en la lista 'elements'
         var pokemon = pokemonProvider.listPokemon.firstWhere(
            (pokemon) => pokemon.data.id == id,
          );

          favouritePokemonDetails.add([
            pokemon.data.id, 
            pokemon.data.name, 
            pokemon.data.xp, 
            pokemon.data.sprite
          ]);  // Agregar detalles del Pokémon favorito
        }
    }
  }

  favouritePokemonDetails.sort((a, b) => a[0].compareTo(b[0])); // Ordenar en orden

  return favouritePokemonDetails;  // Devolver lista
}
}
