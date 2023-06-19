import 'package:flutter/material.dart';

import '/model/meal.dart';
import '/widget/meal_item.dart';
import 'meal_detail.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({
    super.key,
    this.title,
    required this.meal,
  });

  final String? title;
  final List<Meal> meal;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailScreen(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemBuilder: (ctx, index) => MealItem(
        meal[index],
        onSelectMeal: (meal) {
          selectMeal(context, meal);
        },
      ),
      itemCount: meal.length,
    );
    if (meal.isEmpty) {
      content = Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            'Uh oh ... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Try selection a different category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          )
        ]),
      );
    }
    if (title == null) {
      return content;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: content);
  }
}
