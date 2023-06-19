import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/providers/filter_provider.dart';

class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends ConsumerState<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    final filterValue = ref.watch(filterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          buildSwitchListTile(context, (index) {
            ref
                .read(filterProvider.notifier)
                .setFilter(Filter.glutenFree, index);
          }, filterValue[Filter.glutenFree]!, 'Gluten-free',
              'Only include Gluten-free meals.'),
          buildSwitchListTile(
            context,
            (index) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.lactoseFree, index);
            },
            filterValue[Filter.lactoseFree]!,
            'Lactose-free',
            'Only include lactose-free meals.',
          ),
          buildSwitchListTile(
            context,
            (index) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.vegetarian, index);
            },
            filterValue[Filter.vegetarian]!,
            'Vegetarian',
            'Only include vegetarian meals.',
          ),
          buildSwitchListTile(
            context,
            (index) {
              ref.read(filterProvider.notifier).setFilter(Filter.vegan, index);
            },
            filterValue[Filter.vegan]!,
            'Vegan',
            'Only include vegan meals.',
          ),
        ],
      ),
    );
  }

  Widget buildSwitchListTile(
    BuildContext context,
    dynamic updateValue,
    bool valueOfFilter,
    String nameFilter,
    String subFilter,
  ) {
    return SwitchListTile(
      value: valueOfFilter,
      onChanged: updateValue,
      title: Text(
        nameFilter,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        subFilter,
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}
