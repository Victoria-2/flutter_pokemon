import 'package:flutter/material.dart';
import 'package:flutter_pokemon/screens/home_screen.dart';

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
    // final tema = Provider.of<ThemeProvider>(context, listen: true);
    return MaterialApp(
        //debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        /* theme: Preferences.darkmode ? ThemeData.dark() : ThemeData.light(), */
        // theme: tema.temaActual,

        routes: {
          'home': (context) => const HomeScreen(),
          }
        );

    /*return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
        leadingWidth: 40,
        toolbarHeight: 80,
      ),
      drawer: Menu(),
      body: const Center(child: Text('Hola mundo')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.plus_one),
        onPressed: () {
          log('click button');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );*/
  }
}
