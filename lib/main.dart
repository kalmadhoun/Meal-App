import 'package:flutter/material.dart';

import 'dummy_data.dart';
import './screens/filters_screen.dart';
import './screens/tabs.dart';
import './screens/category_meal_screen.dart';
import './screens/meal_details_screen.dart';
import 'models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten' : false,
    'lactose' : false,
    'vegan' : false,
    'vegetarian' : false,
  };

  List<Meal> _availableMeal = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _saveFilters(Map<String, bool> filtersData){
    setState(() {
      _filters = filtersData;
      _availableMeal = DUMMY_MEALS.where((meal) {
        if(_filters['gluten'] && !meal.isGlutenFree)
          return false;
        if(_filters['lactose'] && !meal.isLactoseFree)
          return false;
        if(_filters['vegan'] && !meal.isVegan)
          return false;
        if(_filters['vegetarian'] && !meal.isVegetarian)
          return false;
        return true;
      }).toList();
    });
  }
  void _pressFavorite(String mealId){
    final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if(existingIndex >= 0){
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }else{
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }
  bool _isFavorite(String mealId){
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 219, 219, 1.0),
        textTheme: TextTheme(
          title: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
          body1: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.normal
          ),
        ),
      ),
      routes: {
        '/': (_) => TabsScreen(_favoriteMeals),
        CategoryMealScreen.routeName: (_) => CategoryMealScreen(_availableMeal),
        MealDetailsScreen.routeName: (_) => MealDetailsScreen(_pressFavorite, _isFavorite),
        FiltersScreen.routeName : (_) => FiltersScreen(_filters, _saveFilters),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal"),
      ),
      body: null,
    );
  }
}
