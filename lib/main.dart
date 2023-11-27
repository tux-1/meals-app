import 'package:flutter/material.dart';

import '/011%20dummy-data.dart';
import '/screens/filters_screen.dart';
import '/screens/meal_detail_screen.dart';
import '/screens/tabs_screen.dart';
import 'models/meal.dart';
import 'screens/category_meals_screen.dart';
import 'screens/categories_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten-free': false,
    'lactose-free': false,
    'vegetarian': false,
    'vegan': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten-free']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose-free']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((element) => element.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals app', //App name
      theme: ThemeData(
        //App theme colors here
        scaffoldBackgroundColor: Colors.orange[100],
        appBarTheme:
            AppBarTheme(color: const Color.fromARGB(255, 224, 75, 124)),
        canvasColor: Color.fromARGB(255, 255, 88, 88),
        cardColor: Color.fromARGB(178, 193, 0, 0),
        textTheme: ThemeData.light().textTheme.copyWith(
            //idk what's going on

            bodyLarge: TextStyle(
                // fontFamily: ,
                color: Colors.black)),
      ),
      // home: CategoriesScreen(),    replaced by home route in routes
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      //onGenerateRoute returns you to a known route if you're trying to enter
      //an unknown route, it's just a safety mechanism
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      // },
      onUnknownRoute: (settings) {
        //when unknown route is reached.
        //just like 404 cant be found error on web
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
