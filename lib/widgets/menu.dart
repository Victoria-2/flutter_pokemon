import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final List<Map<String, String>> _menuItems = <Map<String, String>>[
    {'route': 'home', 'title': 'Home', 'subtitle': 'Pagina Principal'},
    //en route va como esta escrito en el home
    {'route': 'pokemon_list', 'title': 'Pokemones', 'subtitle': 'Lista paginada'},
    {'route': 'pokemon-moves', 'title': 'Habilidades', 'subtitle': 'Movimientos'},
    {'route': 'profile_screen', 'title': 'Perfil', 'subtitle': 'Editar tus datos'},
    {'route': 'habilidades_screen', 'title': 'Habilidades', 'subtitle': 'Editar tus datos'},
  ];

  Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const _MenuHeader(),
          ...ListTile.divideTiles(
              context: context,
              tiles: _menuItems
                  .map((item) => ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
                        dense: true,
                        minLeadingWidth: 25,
                        iconColor: Colors.blueGrey,
                        title: Text(item['title']!,
                            style: const TextStyle(fontFamily: 'FuzzyBubbles')),
                        subtitle: Text(item['subtitle'] ?? '',
                            style: const TextStyle(
                                fontFamily: 'RobotoMono', fontSize: 11)),
                        // leading: const Image(image: AssetImage('assets/icon_pokeball.png')), /* Por algun motivo me larga error, creo que es el tamaño del png */
                        leading: const Icon(Icons.arrow_right), //icono al inicio
                        // trailing: const Icon(Icons.arrow_right), // icono al final
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, item['route']!);

                        },
                      ))
                  .toList())
        ],
      ),
    );
  }
}

class _MenuHeader extends StatelessWidget {
  const _MenuHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      padding: EdgeInsets.zero,
      child: Stack(children: [
        const Positioned(
          child: FadeInImage(placeholder: AssetImage('assets/loading_pokeball.gif'), image: AssetImage('assets/logo.png')),
        ),
        Container(
          alignment: Alignment.bottomRight,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: const Text(
            'Desarrollado por grupo 4',
            style: TextStyle(
                fontSize: 13, color: Colors.black54, fontFamily: 'RobotoMono'),
            textAlign: TextAlign.right,
          ),
        ),
      ]),
    );
  }
}
