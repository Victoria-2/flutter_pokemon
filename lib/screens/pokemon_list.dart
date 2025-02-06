import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  Future<void> _futurePokemon = Future.value();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final pokemonProvider =
          Provider.of<PokemonProvider>(context, listen: false);
      setState(() {
        _futurePokemon = pokemonProvider.getPokemon();
      });
    });

    scrollController.addListener(() {
      final pokemonProvider =
          Provider.of<PokemonProvider>(context, listen: false);
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !pokemonProvider.isLoading) {
        print('Final pokemones. Cargando ...');
        setState(() {
          _futurePokemon = pokemonProvider.getPokemon();
        });
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
            if (snapshot.connectionState == ConnectionState.waiting &&
                pokemonProvider.listPokemon.isEmpty) {
              return Center(child: Image.asset('assets/loading_pokeball.gif'));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Column(
                children: [
                  Expanded(
                    child: GridView.count(
                      physics: const BouncingScrollPhysics(),
                      controller: scrollController,
                      crossAxisCount: 2,
                      children: List.generate(
                          pokemonProvider.listPokemon.length, (index) {
                        var pokemon = pokemonProvider.listPokemon[index];
                        return PokemonCard(
                          id: pokemon.data.id,
                          name: pokemon.data.name,
                          sprite: pokemon.data.sprite,
                          xp: pokemon.data.xp,
                        );
                      }),
                    ),
                  ),

                  // pequeño gif de carga cuando se traen mas pokemon
                  if (pokemonProvider.isLoading)
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Image.asset('assets/loading_pokeball.gif',
                            height: 50, width: 50),
                      ),
                    ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
