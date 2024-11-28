import 'package:flutter/material.dart';
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
    'fire': Colors.redAccent,
    'water': Colors.blueAccent,
    'grass': Colors.greenAccent,
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
      backgroundColor: Colors.amberAccent.shade100, // Fondo amarillo dorado.
      appBar: AppBar(
        title: Text(capitalize(name)),
        backgroundColor: backgroundColor,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 16,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: Image.asset(
              'assets/logoPokemon.png',
              height: 100,
              fit: BoxFit.contain,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
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
                        const SizedBox(height: 80), // Espacio para el sprite.
                        Text(
                          capitalize(name),
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '#${number.toString().padLeft(3, '0')}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/${type.toLowerCase()}.svg',
                              height: 24,
                              width: 24,
                              colorFilter: ColorFilter.mode(
                                  backgroundColor, BlendMode.srcIn),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              capitalize(type),
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black54),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Movimientos:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        for (var move in moves)
                          Text(
                            capitalize(move),
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                      ],
                    ),
                  ),
                  // Sprite sobresaliendo
                  Positioned(
                    top: -60,
                    left: MediaQuery.of(context).size.width / 2 - 60,
                    child: Image.network(
                      image,
                      height: 200,
                      width: 200,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, size: 120),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
