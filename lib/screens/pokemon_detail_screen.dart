import 'package:flutter/material.dart';
import 'package:flutter_pokemon/widgets/apodo_pokemon.dart';
import 'package:flutter_pokemon/widgets/favorito_checkbox.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PokemonDetailScreen extends StatelessWidget {
  final String name;
  final String type;
  final String image;
  final int number;
  final List<String> moves;

  PokemonDetailScreen({
    super.key,
    required this.name,
    required this.type,
    required this.image,
    required this.number,
    required this.moves,
  });

  final Map<String, Color> typeColors = {
    'fire': const Color.fromARGB(255, 255, 109, 90),
    'water': Colors.blueAccent,
    'grass': const Color.fromARGB(255, 37, 139, 90),
    'electric': Colors.yellowAccent,
    'psychic': Colors.purpleAccent,
    'normal': Colors.grey,
    'fighting': Colors.orange,
    'rock': Colors.brown,
    'ghost': Colors.deepPurple,
    'ice': Colors.lightBlueAccent,
    'dragon': Colors.indigo,
    'dark': Colors.black87,
    'fairy': Colors.pinkAccent,
    'steel': Colors.blueGrey,
    'ground': Colors.amber,
    'poison': Colors.deepPurpleAccent,
    'bug': Colors.lightGreen,
    'flying': Colors.cyan,
  };

  String capitalize(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = typeColors[type] ?? Colors.grey;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 254, 254),
      appBar: AppBar(
        title: Text(capitalize(name)),
        backgroundColor: backgroundColor,
      ),
      body: Center(
        child: Column(
          children: [
            // Logo Pokémon
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 55.0),
              child: Image.asset(
                'assets/logoPokemon.png',
                height: 150, // Tamaño grande
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Card con información
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 700, // Limitar el ancho del card
                    maxHeight: 1500, // Hacerlo más cuadrado
                  ),
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: backgroundColor.withOpacity(0.5),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 100), // Espacio para el sprite
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Apodo:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    capitalize(name),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    '#${number.toString().padLeft(3, '0')}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          FavoriteCheckbox(
                            initialValue: false,
                            onChanged: (isFavorite) {
                              debugPrint(
                                  '$name es favorito: ${isFavorite ? "Sí" : "No"}');
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ApodoPokemon(),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/${type.toLowerCase()}.svg',
                            height: 24,
                            width: 24,
                            colorFilter: const ColorFilter.mode(
                                Colors.black, BlendMode.srcIn),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            capitalize(type),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Movimientos:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      for (var move in moves)
                        Text(
                          capitalize(move),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                    ],
                  ),
                ),
                // Sprite del Pokémon
                Positioned(
                  top: -100, // Ajustar para que el sprite sobresalga
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Image.network(
                      image,
                      height: 200,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, size: 120),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
