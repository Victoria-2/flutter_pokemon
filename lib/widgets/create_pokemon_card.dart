import 'package:flutter/material.dart';
import 'package:flutter_pokemon/helpers/pokemon_preferences.dart';
import 'package:flutter_pokemon/widgets/create_poke_alert.dart';
import 'package:google_fonts/google_fonts.dart';

class PokemonCard extends StatelessWidget {
  int id;
  String name;
  String sprite;
  int xp;

  PokemonCard({super.key, required this.id, required this.name, required this.sprite, required this.xp});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.red, // Color de la onda
      highlightColor: Colors.blue, // Color antes de la onda
      onTap: () {
        _PokemonAlert(context, id, name, sprite, xp); // Muestrar la card individual cuando se toca
      },
      child: Card(
          shadowColor: Colors.purple[400],
          elevation: 10,
          child:  Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '#$id',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.pressStart2p(),
                        ),
                        _buildFavorite(id),
                    ],
                  ),
                  FadeInImage.assetNetwork(
                    placeholder: 'assets/loading_pokeball.gif',
                    image: sprite,
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                  ),
                  Expanded(
                    child: Container(
                      width: 150,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.blue[200],
                        border: Border.all(
                      ),
                      borderRadius: BorderRadius.circular(10)
                  ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            name,
                            style: GoogleFonts.pressStart2p(),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          ),
        ),
    );
  }
}

void _PokemonAlert(BuildContext context, int id, String name, String sprite, int xp) {
   showDialog(
    context: context,
    builder: (BuildContext context) {
      return PokemonAlert(
        id: id,  
        name: name,
        sprite: sprite,
        xp: xp,
      );
    },
  );

}

Widget _buildFavorite(int id) {
  bool isFavorite = PokemonPreferences.isFavourite(id);

  return Icon(
    isFavorite ? Icons.star : Icons.star_border,
    color: isFavorite ? Colors.yellow : Colors.grey,
    size: 30,
  );
}
  
