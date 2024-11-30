import 'package:flutter/material.dart';
import 'package:flutter_pokemon/widgets/apodo_pokemon.dart';
import 'package:flutter_pokemon/widgets/favorito_checkbox.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokemonDetailScreen extends StatefulWidget {
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
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  late bool isFavorite;
  late TextEditingController apodoController;
  String? savedApodo;

  @override
  void initState() {
    super.initState();
    isFavorite = false; // Valor inicial
    apodoController = TextEditingController();
    _loadPreferences(); // Cargar el favorito y el apodo desde SharedPreferences
  }

  // Método para cargar los datos guardados
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = prefs.getBool('${widget.name}_favorite') ?? false;
      savedApodo = prefs.getString('${widget.name}_apodo');
      apodoController.text = savedApodo ?? '';
    });
  }

  // Método para guardar el estado de favorito
  Future<void> _saveFavorite(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('${widget.name}_favorite', value);
    setState(() {
      isFavorite = value;
    });
  }

  // Método para guardar el apodo
  Future<void> _saveApodo(String apodo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('${widget.name}_apodo', apodo);
    setState(() {
      savedApodo = apodo;
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.typeColors[widget.type] ?? Colors.grey;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 254, 254),
      appBar: AppBar(
        title: Text(widget.capitalize(widget.name)),
        backgroundColor: backgroundColor,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 55.0),
              child: Image.asset(
                'assets/logoPokemon.png',
                height: 150,
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 750, // Ajustar el tamaño del contenedor
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
                      const SizedBox(height: 100),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Columna izquierda: Apodo
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Apodo:',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: TextField(
                                  controller: apodoController,
                                  decoration: const InputDecoration(
                                    hintText: 'Escribe un apodo...',
                                  ),
                                  onSubmitted: (value) {
                                    _saveApodo(value);
                                  },
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                savedApodo ?? 'Sin apodo',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          // Columna derecha: Favorito Checkbox
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'Favorito:',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              FavoriteCheckbox(
                                value: isFavorite, // Pasamos el estado directamente
                                onChanged: (value) {
                                  _saveFavorite(value); // Guardamos el estado en SharedPreferences
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Tipo y Movimientos
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/${widget.type.toLowerCase()}.svg',
                            height: 24,
                            width: 24,
                            colorFilter: const ColorFilter.mode(
                                Colors.black, BlendMode.srcIn),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.capitalize(widget.type),
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
                      for (var move in widget.moves)
                        Text(
                          widget.capitalize(move),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                    ],
                  ),
                ),
                Positioned(
                  top: -100, // Posición del sprite
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Image.network(
                      widget.image,
                      height: 200, // Altura del sprite
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error, size: 120),
                    ),
                  ),
                ),
                Positioned(
                  top: 110, // Ajusta este valor para colocarlo justo debajo del sprite
                  left: 0,
                  right: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.capitalize(widget.name),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '#${widget.number.toString().padLeft(3, '0')}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
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
