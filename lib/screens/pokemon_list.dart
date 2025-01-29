import 'package:flutter/material.dart';
import 'package:flutter_pokemon/models/pokemon_model.dart';
import 'package:flutter_pokemon/providers/pokemon_provider.dart';
import 'package:flutter_pokemon/widgets/create_pokemon_card.dart';
import 'package:flutter_pokemon/widgets/menu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PokemonList extends StatelessWidget {
  final Pokemon? pokemon;
  
  const PokemonList({super.key, this.pokemon});

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
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
        child: listarPokemones(pokemonProvider)
        )
    );
  }


  FutureBuilder<dynamic> listarPokemones(PokemonProvider pokemonProvider) {
  return FutureBuilder<dynamic>(
    future: pokemonProvider.getPokemon(), // 
    builder: (context, AsyncSnapshot<dynamic> snapshot) {
      // ...
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: Image.asset('assets/loading_pokeball.gif'));
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));

      } /* else */ if (snapshot.hasData) {
        var pokemones = snapshot.data!;
        return GridView.count(
          crossAxisCount: 2,  // Número de columnas
          children: List.generate(pokemones.length, (index) { // agarrar la cantidad desde pokemon provider
            var pokemon = pokemones[index];
            int id = pokemon.data.id;
            String name = pokemon.data.name;
            String sprite = pokemon.data.sprite;
            int xp = pokemon.data.xp;

            return PokemonCard(id: id, name: name, sprite: sprite, xp: xp);
          }),
        );
      } else {
        return const Center(child: Text('No Pokémon found.'));
      }
    },
  );
}
}