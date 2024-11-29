import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PokemonAlert extends StatelessWidget {
  int id;
  String name;
  int xp;
  String sprite;

  PokemonAlert({super.key, required this.id, required this.name, required this.xp, required this.sprite});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 5,
      title: Text('Información del Pokémon', style: GoogleFonts.pressStart2p(fontSize: 16)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ContenidoPokeAlerta(id: id, sprite: sprite, name: name, xp: xp), // Asegúrate de pasar los datos correctos
          SizedBox(height: 10),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Cierra el diálogo
          },
          child: Text('Volver', style: GoogleFonts.pressStart2p(fontSize: 16)),
        ),
      ],
    );
  }
}

class ContenidoPokeAlerta extends StatelessWidget {
  const ContenidoPokeAlerta({
    super.key,
    required this.id,
    required this.sprite,
    required this.name,
    required this.xp,
  });

  final int id;
  final String sprite;
  final String name;
  final int xp;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.purple[400],
      elevation: 10,
    
      child:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            children: [
              Text(
                '#$id',
                textAlign: TextAlign.start,
                style: GoogleFonts.pressStart2p(),
                ),
              FadeInImage.assetNetwork(
                placeholder: 'assets/loading_pokeball.gif',
                image: sprite,
                height: 150,
                width: 150,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 10),
              Text(name, style: GoogleFonts.pressStart2p(fontSize: 18)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text('XP: ', style: GoogleFonts.pressStart2p(fontSize: 16)),
                Text('$xp', style: GoogleFonts.pressStart2p(fontSize: 16)),
          ],
        ),
      ],
      )
      )
    );
  }
}
