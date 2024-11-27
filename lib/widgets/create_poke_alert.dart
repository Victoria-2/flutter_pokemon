import 'package:flutter/material.dart';

class PokemonAlert extends StatelessWidget {
  int id;
  String name;
  int xp;
  String sprite;

  PokemonAlert({super.key, required this.id, required this.name, required this.xp, required this.sprite});

  @override
  Widget build(BuildContext context) {
    return contenidoAlerta(id: id, sprite: sprite, name: name, xp: xp);
  }
}

class contenidoAlerta extends StatelessWidget {
  const contenidoAlerta({
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
                ),
              FadeInImage.assetNetwork(
                placeholder: 'assets/loading_pokeball.gif',
                image: sprite,
                height: 150,
                width: 150,
                fit: BoxFit.contain,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    border: Border.all(
                  ),
                  borderRadius: BorderRadius.circular(10)
              ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(name),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('XP: '), // quiero que tenga una imagen que sea re tierna
                          Text('$xp'),
                        ],
                      )
                    ]
                  ),
                ),
              )
            ],
          ),
      ),
    );
  }
}