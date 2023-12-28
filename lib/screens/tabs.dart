// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widget/main_drawer.dart';
const KInitialFilter={
   Filter.glutenFree: false,
    Filter.lactosefree: false,
    Filter.vegetarian: false,
    Filter.vegan: false
};
class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  Map<Filter, bool> _selectedFilters = KInitialFilter;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  final List<Meal> _favoriteMeals = [];
  void _showinfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ));
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showinfoMessage("Meal is no longer a favorite.");
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showinfoMessage("Marked as a favorite!");
      });
    }
  }

  void _setScreen(String indentifier) async {
    Navigator.of(context)
        .pop(); //  filter mathi direct tab screen ma avi jasu drawer ma nay jayi anthi ui sari lagse
    // jo apde pop method else ma nakhyi hot to apde drawer ma j ret je saru no lage atla mate pop method bar rakhi che

    if (indentifier == "filters") {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) =>FiltersScreen(currentFilters:_selectedFilters)));
          setState(() {
            _selectedFilters=result??KInitialFilter;
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals=dummyMeals.where((meal) {
      if(_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree){
        return false;
      }
       if(_selectedFilters[Filter.lactosefree]! && !meal.isLactoseFree){
        return false;
      }
       if(_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian){
        return false;
      }
       if(_selectedFilters[Filter.vegan]! && !meal.isVegan){
        return false;
      }
      return true;
    }).toList();
    Widget activePage =
        CategoriesScreen(onToggleFavorite: _toggleMealFavoriteStatus, availableMeals: availableMeals,);
    var activePageTitle = "Categories";
    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
          meals: _favoriteMeals, onToggleFavorite: _toggleMealFavoriteStatus);
      activePageTitle = "Your Favorites";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
// Widget MainDrawer(BuildContext context){
//    return Drawer(
//       child: Column(children: [
//         DrawerHeader(
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//               gradient: LinearGradient(colors: [
//             Theme.of(context).colorScheme.primaryContainer,
//             Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8),
//           ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
//           child: Row(children: [
//             Icon(
//               Icons.fastfood,
//               size: 48,
//               color: Theme.of(context).colorScheme.primary,
//             ),
//             const SizedBox(width: 18),
//             Text(
//               "Cooking Up!",
//               style: Theme.of(context)
//                   .textTheme
//                   .titleLarge!
//                   .copyWith(color: Theme.of(context).colorScheme.primary),
//             )
//           ]),
//         )
//       ]),
//     );
// }
