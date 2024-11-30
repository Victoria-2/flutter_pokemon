import 'package:flutter/material.dart';
import 'package:flutter_pokemon/screens/alert_pokemon_screen.dart';
import 'package:flutter_pokemon/screens/habilidades_screen.dart';
import 'package:flutter_pokemon/screens/home_screen.dart';
import 'package:flutter_pokemon/screens/pokemon_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pokemon/providers/theme_provider.dart';
import 'package:flutter_pokemon/screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme(); // Cargar el tema guardado

  runApp(
    ChangeNotifierProvider(
      create: (_) => themeProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


@override
Widget build(BuildContext context) {
  final tema = Provider.of<ThemeProvider>(context);

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'home',
    theme: tema.temaActual, // Aplica el tema dinámico
    routes: {
      'home': (context) => const HomeScreen(),
      'profile_screen': (context) => const ProfileScreen(),
      'pokemon_list': (context) => const PokemonList(),
      'alert_pokemon_screen': (context) => const PokemonAlertScreen(),
      'habilidades_screen': (context) => const PokemonListScreen(),
    },
  );
}
}