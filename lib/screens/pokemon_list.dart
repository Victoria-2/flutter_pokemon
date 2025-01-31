import 'package:flutter/material.dart';
import 'package:flutter_pokemon/models/pokemon_model.dart';
import 'package:flutter_pokemon/providers/pokemon_provider.dart';
import 'package:flutter_pokemon/widgets/create_pokemon_card.dart';
import 'package:flutter_pokemon/widgets/menu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PokemonList extends StatefulWidget {
  final Pokemon? pokemon;
  
  const PokemonList({super.key, this.pokemon});

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  final ScrollController scrollController = ScrollController();
  late Future<void> _futurePokemon;

  @override
  void initState() {
    super.initState();
    final pokemonProvider = Provider.of<PokemonProvider>(context, listen: false);
    _futurePokemon = pokemonProvider.getPokemon();
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent && !pokemonProvider.isLoading) {
        print('Final pokemones. Cargando ...');
        _futurePokemon = pokemonProvider.getPokemon();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pokedex', 
          style: GoogleFonts.pressStart2p(fontSize: 16),
          ),
        centerTitle: true,
        leadingWidth: 40,
        toolbarHeight: 80,
        backgroundColor: Colors.red[400],
        shadowColor: Colors.purple[400],
        elevation: 5,
      ),
      drawer: Menu(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<void>(
          future: _futurePokemon,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting && pokemonProvider.listPokemon.isEmpty) {
              return Center(child: Image.asset('assets/loading_pokeball.gif'));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (pokemonProvider.listPokemon.isEmpty) {
              return const Center(child: Text('No Pokémon found.'));
            } else {
              return GridView.count(
                controller: scrollController,
                crossAxisCount: 2,
                children: List.generate(pokemonProvider.listPokemon.length, (index) {
                  var pokemon = pokemonProvider.listPokemon[index];
                  return PokemonCard(
                    id: pokemon.data.id,
                    name: pokemon.data.name,
                    sprite: pokemon.data.sprite,
                    xp: pokemon.data.xp,
                  );
                }),
              );
            }
          },
        ),
      ),
    );
  }
}