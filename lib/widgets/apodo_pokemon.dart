import 'package:flutter/material.dart';

class ApodoPokemon extends StatefulWidget {
  @override
  _ApodoPokemonState createState() => _ApodoPokemonState();
}

class _ApodoPokemonState extends State<ApodoPokemon> {
  String apodo = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Apodo:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Ingresa un apodo',
          ),
          onChanged: (value) {
            setState(() {
              apodo = value;
            });
          },
        ),
        const SizedBox(height: 8),
        Text(
          'Apodo actual: $apodo',
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}