import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PokemonApiService {
  static const String _baseUrl = 'https://pokeapi.co/api/v2';

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
      if (kDebugMode) {}
      return [];
    }
  }

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
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=100');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List results = data['results'];

        final detailedPokemon = await Future.wait(results.map((pokemon) async {
          final detailResponse = await http.get(Uri.parse(pokemon['url']));
          if (detailResponse.statusCode == 200) {
            final detailData = jsonDecode(detailResponse.body);
            return {
              'name': detailData['name'],
              'type': detailData['types'][0]['type']['name'],
              'number': detailData['id'],
              'image': detailData['sprites']['front_default'],
              'moves': (detailData['moves'] as List)
                  .map((move) => move['move']['name'].toString())
                  .toList(),
            };
          }
          return null;
        }));

        return detailedPokemon
            .where((pokemon) => pokemon != null)
            .cast<Map<String, dynamic>>()
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
