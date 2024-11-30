import 'package:flutter/material.dart';
import '../helpers/habilidades_pokemon.dart';
import '../widgets/pokemon_card.dart';
import '../widgets/menu.dart'; // Importa el archivo de menú

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});

  @override
  PokemonListScreenState createState() => PokemonListScreenState();
}

class PokemonListScreenState extends State<PokemonListScreen> {
  final PokemonApiService _apiService = PokemonApiService();
  List<Map<String, dynamic>> _pokemons = [];
  bool _isLoading = true;

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

  @override
  void initState() {
    super.initState();
    _fetchPokemons();
  }

  Future<void> _fetchPokemons() async {
    final pokemons = await _apiService.getAllPokemon(); // Ya devuelve List<Pokemon>
    setState(() {
      _pokemons = pokemons;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pokémon'),
      ),
      // Aquí agregamos el Drawer usando tu clase Menu
      drawer: Menu(), // Aquí es donde agregamos tu menú
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _pokemons.length,
              itemBuilder: (context, index) {
                final pokemon = _pokemons[index];
                final type = pokemon['type']; // Extraemos el tipo
                final color = typeColors[type] ?? Colors.grey; // Asignamos color

                return PokemonCard(
                  name: pokemon['name'],
                  type: pokemon['type'],
                  number: pokemon['number'],
                  image: pokemon['image'],
                  color: color,
                );
              },
            ),
    );
  }
}
