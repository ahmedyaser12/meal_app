import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/providers/favorite_provider.dart';

import '/model/meal.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeal = ref.watch(favoriteMealProvider);
    final isFavorite = favoriteMeal.contains(meal);

    List build(String name, var steps) {
      return [
        Text(
          name,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 14),
        for (final variable in steps)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: Text(
                variable,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
          )
      ];
    }

//final isFavorite=favoriteMeals.contains(meal);
    return Scaffold(
      appBar: AppBar(title: Text(meal.title), actions: [
        IconButton(
          onPressed: () {
            final wasAdded = ref
                .read(favoriteMealProvider.notifier)
                .toggleMealFavoriteStatus(meal);
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text(wasAdded ? 'Meal added a favorite' : 'meal removed'),
              ),
            );
          },
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return RotationTransition(
                turns: Tween(begin: 0.8, end: 1.0).animate(animation),
                child: child,
              );
            },
            child: Icon(
              isFavorite ? Icons.star : Icons.star_border,
              key: ValueKey(isFavorite),
            ),
          ),
        ),
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: Image.network(
                meal.imageUrl,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            ...build('Ingredient', meal.ingredients),
            const SizedBox(
              height: 15,
            ),
            ...build('Steps', meal.steps),
          ],
        ),
      ),
    );
  }
}
