import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/providers/favorite_provider.dart';
import 'package:mealapp/providers/filter_provider.dart';

import '/screen/categories.dart';
import '/screen/filter.dart';
import '/screen/meal.dart';
import '../widget/drawer.dart';

const kInitialFilters = [false, false, false, false];

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int selectIndex = 0;

  void setSelect(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<List<bool>>(
        MaterialPageRoute(builder: (_) => const FilterScreen()),
      );
    }
  }

  void _selectPage(int index) {
    setState(() {
      selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    var activePageTitle = 'Categories';

    Widget activeScreen = CategoriesScreen(availableMeals: availableMeals);

    if (selectIndex == 1) {
      final favoriteMeal = ref.watch(favoriteMealProvider);
      activeScreen = MealScreen(
        meal: favoriteMeal,
      );
      activePageTitle = 'Your Favorite';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelect: setSelect,
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorite'),
        ],
      ),
    );
  }
}
