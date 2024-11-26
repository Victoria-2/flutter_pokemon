import 'package:flutter/material.dart';
import 'package:flutter_pokemon/helpers/preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Aplicación'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text(
                'Menú',
                style: TextStyle(fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('Perfil'),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              title: const Text('Habilidades Pokémon'),
              onTap: () {
                Navigator.pushNamed(context, '/pokemon-moves');
              },
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('Tema oscuro'),
              value: Preferences.isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  Preferences.isDarkMode = value; 
                });
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('¡Bienvenido a la aplicación!'),
      ),
    );
  }
}