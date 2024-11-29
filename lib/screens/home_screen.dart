import 'package:flutter/material.dart';
import 'package:flutter_pokemon/screens/pokemon_list.dart';
import 'package:flutter_pokemon/widgets/create_pokemon_card.dart';
import 'package:flutter_pokemon/widgets/menu.dart';
import 'dart:developer';
import 'package:flutter_pokemon/mocks/pokemon_mock.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    log(' ${size.width} ${size.height}');

    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex', style: GoogleFonts.pressStart2p(fontSize: 16)),
        centerTitle: true,
        leadingWidth: 40,
        toolbarHeight: 80,
        shadowColor: Colors.deepPurple,
        elevation: 5,
      ),
      drawer: Menu(),
      body: Column(
      children: [
        CarusselImagenes(size: size),
        Divider(thickness: 3),
        Padding(
          padding: EdgeInsets.all(10),
          child: HorizontalSwipper(size: size)
          )
      ],
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
            Image.asset('assets/img/logo.png'),
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
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.35,
      child: Column(
        crossAxisAlignment:  CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: SwipperHeader(),
            ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: elements.length,
              itemBuilder: (context, index) {
                var pokemon = elements[index];
                int id = pokemon[0];
                String name = pokemon[1];
                int xp = pokemon[2];  
                String sprite = pokemon[3];
                
                return PokemonCard(id: id, name: name, sprite: sprite, xp: xp);
              },
            )
            )
        ],
      ),
    );
  }
}

class SwipperHeader extends StatelessWidget {
  const SwipperHeader({
    super.key,
  });

  //agregarlo de los size y extended

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Lista de Pokemones', style: GoogleFonts.pressStart2p(fontSize: 12)),
        //SizedBox(width: 200),
        ElevatedButton(
          onPressed: () {
        // Navegar a la pantalla de detalles
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PokemonList()),
        );
      },
          child: Text('Ver todos', style: GoogleFonts.pressStart2p(fontSize: 8))
        ),
      ],
    );
  }
}
