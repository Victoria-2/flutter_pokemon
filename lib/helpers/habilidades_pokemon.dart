import 'dart:convert'; // Para trabajar con JSON
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http; // Paquete HTTP

class PokemonApiService {
  static const String _baseUrl = 'https://pokeapi.co/api/v2';

  /// Obtiene los movimientos de los Pokémon
  Future<List<String>> getPokemonMoves() async {
    final url = Uri.parse('$_baseUrl/move?limit=50');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List results = data['results'];

        return results.map((e) => e['name'].toString()).toList();
      } else {
        throw Exception('Error al obtener los movimientos');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return [];
    }
  }

  /// Obtiene detalles de un movimiento por ID
  Future<Map<String, dynamic>> getMoveById(int id) async {
    final url = Uri.parse('$_baseUrl/move/$id');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Movimiento no encontrado');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return {};
    }
  }

  /// Obtiene los movimientos filtrados por tipo
  Future<List<Map<String, dynamic>>> getMovesByType(String type) async {
    final url = Uri.parse('$_baseUrl/move?limit=100');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List results = data['results'];

        final detailedMoves = await Future.wait(results.map((move) async {
          final detailResponse = await http.get(Uri.parse(move['url']));
          return detailResponse.statusCode == 200
              ? jsonDecode(detailResponse.body)
              : null;
        }));

        return detailedMoves
            .where((move) => move != null && move['type']['name'] == type)
            .map((move) => {'name': move['name'], 'type': move['type']['name']})
            .toList();
      } else {
        throw Exception('Error al obtener movimientos por tipo');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return [];
    }
  }
  

  Future<List<Map<String, dynamic>>> getAllPokemon() async {
  final url = Uri.parse('$_baseUrl/pokemon?limit=100');
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];

      final detailedPokemon = await Future.wait(results.map((pokemon) async {
        final detailResponse = await http.get(Uri.parse(pokemon['url']));
        return detailResponse.statusCode == 200
            ? jsonDecode(detailResponse.body)
            : null;
      }));

      return detailedPokemon
          .where((pokemon) => pokemon != null)
          .map((pokemon) => {
                'name': pokemon['name'],
                'type': pokemon['types'][0]['type']['name'],
                'number': pokemon['id'],
                'image': pokemon['sprites']['front_default'],
                'moves': pokemon['moves']
                    .take(2) // Tomar solo los dos primeros movimientos
                    .map((move) => move['move']['name'])
                    .toList(),
              })
          .toList();
    } else {
      throw Exception('Error al obtener Pokémon');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error: $e');
    }
    return [];
  }
}
}
