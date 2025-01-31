import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_pokemon/models/poke_response_model.dart';
import 'package:flutter_pokemon/models/pokemon_model.dart';
import 'package:http/http.dart' as http;

class PokemonProvider extends ChangeNotifier {
  List<Pokemon> listPokemon = [];
  bool isLoading = false;

  PokemonProvider() {
    print('Llamando a PokemonProvider');
    this.getPokemon();
  }

  Future<void> getPokemon([int limit = 10]) async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    try {
      final url = Uri.https('tp-api-pokemon.onrender.com',
          '/api/v1/pokemons/', {'offset': '1', 'limit': '$limit'});

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final pokeResponse = pokeResponseFromJson(response.body);

        for (var result in pokeResponse.data.results) {
          final pokemonId = _extraerIdUrl(result.url);
          final pokemon = await getPokemonById(pokemonId);

          if (pokemon != null) {
            listPokemon.add(pokemon);
          }
        }
      } else {
        print('Error en el servicio: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al realizar el request: $e');
    } finally {
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

  int _extraerIdUrl(String url) {
    try {
      print('URL recibida para extraer el ID: $url');
      final segments = Uri.parse(url).pathSegments;
      print('Segmentos extraídos: $segments');

      if (segments.isNotEmpty) {
        String idString = segments[segments.length - 2];
        final id = int.parse(idString);
        print('El id es: $id');
        return id;
      } else {
        throw FormatException('La URL no tiene segmentos válidos');
      }
    } catch (e) {
      print('Error al extraer el ID: $e');
      return -1;
    }
  }
}