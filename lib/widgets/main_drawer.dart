import 'package:flutter/material.dart';
import 'package:webplatformtest/screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildListTile(String title, IconData icon, Function tapHandler) {
      return ListTile(
        leading: Icon(
          icon,
          size: 26,
        ),
        title: Text(title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        onTap: () {
          tapHandler();
        },
      );
    }

    return Drawer(
        child: Column(
      children: [
        Container(
            color: Theme.of(context).primaryColor,
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Drawer!',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Colors.amberAccent),
            )),
        const SizedBox(height: 20),
        buildListTile('Meals', Icons.restaurant, () {
          Navigator.of(context).pushReplacementNamed('/');
        }),
        buildListTile('Filters', Icons.settings, () {
          Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
        }),
      ],
    ));
  }
}
