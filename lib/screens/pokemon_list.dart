import 'package:flutter/material.dart';
import 'package:flutter_pokemon/widgets/menu.dart';

class PokemonList extends StatelessWidget {
  const PokemonList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
        centerTitle: true,
        leadingWidth: 40,
        toolbarHeight: 80,
        shadowColor: Colors.deepPurple,
        elevation: 5,
      ),
      drawer: Menu(),
      body: const Center(child: Text('traer la lista pokemon')),
    );
  }
}