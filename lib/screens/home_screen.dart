import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:flutter_pokemon/widgets/menu.dart';
=======
>>>>>>> Stashed changes

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< Updated upstream
        title: const Text('Pokedex'),
        centerTitle: true,
        leadingWidth: 40,
        toolbarHeight: 80,
        shadowColor: Colors.deepPurple,
        elevation: 5,
      ),
      drawer: Menu(),
      body: const Center(child: Text('Aca va algun List View con los pokemon y elementos')),
    );
  }
}
=======
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menú'),
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
          ],
        ),
      ),
      body: const Center(child: Text('Bienvenido a la Home Screen')),
    );
  }
}
>>>>>>> Stashed changes
