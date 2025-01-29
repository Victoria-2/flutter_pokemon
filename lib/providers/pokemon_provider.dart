import 'dart:convert';

import 'package:flutter/foundation.dart';
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
      final pokemonsList = List<Pokemon>.from( // NO TIENE QUE SER UNA LISTA !! -- o si, ya no tengo idea la verdad
        json.decode(response.body)['msg'].map((x) => Pokemon.fromJson(x))
      );
      listPokemon = [...listPokemon, ...pokemonsList]; // Expandir la lista de Pokémon
      print('Petición realizada a Poke-API $currentPage');
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
}
