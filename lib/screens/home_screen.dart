import 'package:flutter/material.dart';
import 'package:flutter_pokemon/screens/pokemon_list.dart';
import 'package:flutter_pokemon/widgets/create_pokemon_card.dart';
import 'package:flutter_pokemon/widgets/menu.dart';
import 'dart:developer';
import 'package:flutter_pokemon/mocks/pokemon_mock.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    log(' ${size.width} ${size.height}');

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
      body: Column( // para poner mas de una lista de cosas
      children: [
        //agregar un carrusel de imagenes
        CarusselImagenes(),
        HorizontalSwipper(size: size)
      ],
      )
    );
  }
}

//carrusel de imagenes
class CarusselImagenes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
          items: [
            // Aquí agregamos las imágenes o widgets que quieres mostrar
            Image.asset('assets/img/logo.png'),
            Image.asset('assets/icon_pokeball.png'),
            // Puedes agregar cualquier widget como íconos, textos, etc.
            //Text('Imagen 1', style: TextStyle(color: Colors.white)),
            //Text('Imagen 2', style: TextStyle(color: Colors.white)),
          ],
          options: CarouselOptions(
            height: 400,  // Altura del carrusel
            enlargeCenterPage: true,  // Hace que el ítem central se agrande
            autoPlay: true,  // Hace que el carrusel cambie automáticamente
            enableInfiniteScroll: true,  // Habilita el desplazamiento infinito
            autoPlayInterval: Duration(seconds: 3),  // Intervalo de tiempo entre imágenes
            viewportFraction: 0.8,  // Ajusta el tamaño de la imagen visible
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
      height: size.height * 0.5,
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
        Text('Lista de Pokemones'),
        //SizedBox(width: 200),
        ElevatedButton(
          onPressed: () {
        // Navegar a la pantalla de detalles
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PokemonList()),
        );
      },
          child: Text('Ver todos')
        ),
      ],
    );
  }
}
