import 'package:flutter/material.dart';
import 'package:flutter_pokemon/screens/habilidades_screen.dart';
import 'package:flutter_pokemon/screens/home_screen.dart';
import 'package:flutter_pokemon/screens/pokemon_list.dart';
import 'package:flutter_pokemon/screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Preferences.initShared(); /* es una clase a parte con las perefencias del usuario y se guardan */
  // await doenv.load(); /* no se xq da error */

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


 @override
  Widget build(BuildContext context) {
    // final tema = Provider.of<ThemeProvider>(context, listen: true); /* esto es lo de  */
    return MaterialApp(
        //debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        /* theme: Preferences.darkmode ? ThemeData.dark() : ThemeData.light(), */
        // theme: tema.temaActual,

        routes: {
          'home': (context) => const HomeScreen(),
          'profile_screen': (context) => const ProfileScreen(),
          'pokemon_list': (context) => const PokemonList(),
          'habilidades_screen': (context) => const PokemonListScreen(),
          }
        );
  }
}
