import 'package:flutter/material.dart';
import 'package:flutter_pokemon/screens/home_screen.dart';
import 'package:flutter_pokemon/screens/pokemon_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Preferences.initShared();
  // await doenv.load(); /* no se xq da error */

   runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


 @override
  Widget build(BuildContext context) {
    // final tema = Provider.of<ThemeProvider>(context, listen: true);
    return MaterialApp(
        //debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        //theme: Preferences.darkmode ? ThemeData.dark() : ThemeData.light(),
        // theme: tema.temaActual,

        routes: {
          'home': (context) => const HomeScreen(),
          'pokemon_list': (context) => const PokemonList(),
          }
        );
  }
}
