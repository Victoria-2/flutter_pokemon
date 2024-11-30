import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pokemon/providers/theme_provider.dart';
import 'package:flutter_pokemon/widgets/menu.dart'; // Asegurate de importar el Menu correctamente

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      drawer: Menu(), // Agregamos el menú lateral aquí
      body: Column(
        children: [
          SwitchListTile(
            title: const Text('Tema oscuro'),
            value: themeProvider.isDarkMode,
            onChanged: (bool value) {
              themeProvider.toggleTheme(); // Cambia el tema
            },
          ),
        ],
      ),
    );
  }
}
