import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mealsDescriptios/screens/category_meal_screen.dart';
import 'package:mealsDescriptios/widgets/category_item.dart';
import '../dummy_data.dart';

class MealDetailsScreen extends StatelessWidget {
  static const String routeName = 'meal_detail';

  final Function pressFavorite;
  final Function isFavorite;

  MealDetailsScreen(this.pressFavorite, this.isFavorite);

  Widget sectionTitle(BuildContext ctx, String text) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Text(
        text,
        style: Theme.of(ctx).textTheme.title,
      ),
    );
  }

  Widget sectionContent(Widget child) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(10),
      width: 350,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 1.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal =
        DUMMY_MEALS.firstWhere((element) => element.id == mealId);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            sectionTitle(context, "Ingredients"),
            sectionContent(ListView.builder(
              itemBuilder: (ctx, index) => Card(
                color: Theme.of(context).primaryColor.withOpacity(.5),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    selectedMeal.ingredients[index],
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
              ),
              itemCount: selectedMeal.ingredients.length,
            )),
            sectionTitle(context, "Steps"),
            sectionContent(ListView.builder(
              itemBuilder: (ctx, index) => Card(
                color: Theme.of(context).primaryColor.withOpacity(.5),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    selectedMeal.steps[index],
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
              ),
              itemCount: selectedMeal.steps.length,
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => pressFavorite(mealId),
        child: Icon(
          isFavorite(mealId) ? Icons.favorite : Icons.favorite_border,
          size: 30,
          color: Colors.red,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
