import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import './categories_view.dart';
import './favorites_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  TabsScreen(this.favoriteMeals);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  late List<Map<String, Widget>> _pages;

  @override
  void initState() {
    _pages = [
      {'page': CategoriesScreen(), 'title': Text('Categories')},
      {
        'page': FavoritesScreen(widget.favoriteMeals),
        'title': Text('Your Favorites')
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _pages[_selectedPageIndex]['title'],
        //   bottom: TabBar(tabs: <Widget>[
        //     Tab(
        //       //first screen
        //       text: 'Categories',
        //       icon: Icon(Icons.category),
        //     ),
        //     Tab(
        //         //second screen
        //         icon: Icon(Icons.star),
        //         text: 'Favorites')
        //   ]),
        // ),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Colors.amber,
          // unselectedItemColor: Colors.white,
          selectedItemColor: Colors.black,
          currentIndex: _selectedPageIndex,
          // type: BottomNavigationBarType.shifting,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
          ]),
    );
  }
}
