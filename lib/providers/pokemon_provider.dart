import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_pokemon/models/poke_response_model.dart';
import 'package:flutter_pokemon/models/pokemon_model.dart';
import 'package:http/http.dart' as http;

class PokemonProvider extends ChangeNotifier {
  List<Pokemon> listPokemon = [];
  int currentPage = 1;
  bool isLoading = false;

  PokemonProvider() {
    print('Llamando a PokemonProvider');
    this.getPokemon();
  }

  getPokemon([int limit = 10]) async { // xq el limite es 10 ? -- tengo que pagar page tambien (?
    try {
      final url = Uri.https('tp-api-pokemon.onrender.com',
          '/api/v1/pokemons/', {'offset': '$currentPage', 'limit': '$limit'});

      isLoading = true;
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final pokeResponse = pokeResponseFromJson(response.body);
        for (var result in pokeResponse.data.results) { // CAMBIAR EL NOMBRE DE 'result'
          print('URL del Pokémon: ${result.url}');
          final pokemonId = _extraerIdUrl(result.url);
          await getPokemonById(pokemonId);
        }
      currentPage++;

      } else {
        print('Error en el servicio: ${response.statusCode}');
      }

    } catch (e) {
      print('Error al realizar el request: $e');
    
    } finally { // se ejecuta siempre luego de los anteriores
      isLoading = false;
      notifyListeners();
    }
  }

  Future<Pokemon?> getPokemonById(int id) async {
    try {
      final url = Uri.https(
          'tp-api-pokemon.onrender.com', '/api/v1/pokemons/$id');
      print(url);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print('.....${Pokemon.fromJson(json.decode(response.body))}');
        return Pokemon.fromJson(json.decode(response.body));
      
      } else {
        print('Error en el servicio: ${response.statusCode}');
        return null;
      }

    } catch (e) {
      print('Error al realizar el request: $e');
      return null;
    }
  }

  // AUXILIAR
  int _extraerIdUrl(String url) {
    try {
    print('URL recibida para extraer el ID: $url');

    // Dividimos la URL en segmentos utilizando Uri.parse
    final segments = Uri.parse(url).pathSegments;

    print('Segmentos extraídos: $segments');

    if (segments.isNotEmpty) {
      // Tomamos el último segmento, que debe ser el ID (como '2' en '/api/v2/pokemon/2/')
      String idString = segments[segments.length - 2];

      // Intentamos convertir el segmento a un número
      final id = int.parse(idString);

      return id; // Devolvemos el ID si es válido
    } else {
      throw FormatException('La URL no tiene segmentos válidos');
    }
  } catch (e) {
    print('Error al extraer el ID: $e');
    return -1; // Si hay un error, devolvemos un valor por defecto (indicado como error)
  }
  }
}
