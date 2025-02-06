import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_pokemon/helpers/pokemon_preferences.dart';
import 'package:flutter_pokemon/models/pokemon_model.dart';
import 'package:flutter_pokemon/providers/pokemon_provider.dart';
import 'package:flutter_pokemon/screens/habilidades_screen.dart';
import 'package:flutter_pokemon/screens/pokemon_list.dart';
import 'package:flutter_pokemon/widgets/create_pokemon_card.dart';
import 'package:flutter_pokemon/widgets/menu.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final Pokemon? pokemon;
  
  const HomeScreen({super.key, this.pokemon});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  Future<void> _futurePokemon = Future.value();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final pokemonProvider = Provider.of<PokemonProvider>(context, listen: false);
      setState(() {
        _futurePokemon = pokemonProvider.getPokemon();
      });
    });

  }
  

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);
    final size = MediaQuery.of(context).size;

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
      body:  SingleChildScrollView(
        child: Column(
        children: [
          CarusselImagenes(size: size),
          const Divider(thickness: 3),
          Padding(
            padding: const EdgeInsets.all(10),
            child: 
              FutureBuilder<void>(
          future: _futurePokemon,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting || pokemonProvider.listPokemon.isEmpty) {
              return Center(child: Image.asset('assets/loading_pokeball.gif'));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return HorizontalSwipper( size: size, lista: pokemonProvider.listPokemon, titulo: 'Lista de Pokemones', vinculo: const PokemonList());
            }
          },
        ),
            ),
            const Divider(thickness: 3),
            const Padding(
              padding: EdgeInsets.all(10),
              child: SwipperHeader(titulo: 'Habilidades', vinculo: PokemonListScreen())),
              const Divider(thickness: 3),
          Padding( 
            padding: const EdgeInsets.all(10), 
            child:
            FutureBuilder<void>(
          future: _futurePokemon,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting || pokemonProvider.listPokemon.isEmpty) {
              return Center(child: Image.asset('assets/loading_pokeball.gif'));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return HorizontalSwipper(size: size, lista:PokemonPreferences.getAllFavouritePokemon(pokemonProvider), titulo: 'Favoritos', vinculo: null);
            }
          },
        ),
            ),
            const SizedBox(height: 20)
        ],
        ),
      )
    );
  }
}

//carrusel de imagenes
class CarusselImagenes extends StatelessWidget {
  const CarusselImagenes({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
          items: [
            // aca van las rutas de las imagenes, fijarme is puedo ponerle el loading
            Image.asset('assets/logo.png'),
            Image.asset('assets/icon_pokeball.png'),
          ],
          options: CarouselOptions(
            height: size.height * 0.30, 
            enlargeCenterPage: true,
            autoPlay: true,
            enableInfiniteScroll: true,
            autoPlayInterval: Duration(seconds: 3),
            viewportFraction: 0.8, 
          )
    );
  }
}


// swippers
class HorizontalSwipper extends StatelessWidget {
  const HorizontalSwipper({
    super.key,
    required this.size,
    required this.lista,
    required this.titulo,
    required this.vinculo,
  });

  final Size size;
  final List<dynamic> lista;
  final String titulo;
  final Widget? vinculo;

  @override
  Widget build(BuildContext context) {
    bool isLonger = lista.length > 10;
    
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.35,
      child: Column(
        crossAxisAlignment:  CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SwipperHeader(titulo: titulo, vinculo: vinculo),
            ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 10 + (isLonger ? 1 : 0),
              itemBuilder: (context, index) {

                if (isLonger && index == 10) {
                  return IsLongerCard();
                }

                var pokemon = lista[index];

                if (lista is List<Pokemon>) {
                  return PokemonCard(
                    id: pokemon.data.id,
                    name: pokemon.data.name,
                    sprite: pokemon.data.sprite,
                    xp: pokemon.data.xp,
                  );
                }

                if (lista is List<List<dynamic>>) {
                  return PokemonCard(
                    id: pokemon[0],
                    name: pokemon[1],
                    sprite: pokemon[3],
                    xp: pokemon[2],
                  );
                }
                
              },
            )
            )
        ],
      ),
    );
  }
}

class IsLongerCard extends StatelessWidget {
  const IsLongerCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PokemonList()),
        );
      },
      child: Card(
        shadowColor: Colors.purple[400],
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ver más',
                    style: GoogleFonts.pressStart2p(fontSize: 14),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    size: 30,
                    color: Colors.purple[400],
                  ),
                ],
          ),
        ),
      ),
    );
  }
}

class SwipperHeader extends StatelessWidget {
  const SwipperHeader({
    super.key,
    required this.titulo,
    required this.vinculo,
  });

  final String titulo;
  final Widget? vinculo;

  //agregarlo de los size y extended

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titulo, style: GoogleFonts.pressStart2p(fontSize: 12)),
         if (vinculo != null)
         ElevatedButton(
          onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => vinculo!),
        );
      },
          child: Text('Ver todos', style: GoogleFonts.pressStart2p(fontSize: 8))
        ),
      ],
    );
  }
}
