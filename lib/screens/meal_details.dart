import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

// ignore: must_be_immutable
class MealDetailsScreen extends StatelessWidget {
   MealDetailsScreen({super.key, required this.meal,required this.onToggleFavorite});
  final Meal meal;
  void Function(Meal meal) onToggleFavorite;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
          actions: [
            IconButton(onPressed:(){
              onToggleFavorite(meal);
            }, icon:const Icon(Icons.star))
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Image.network(
                meal.imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 14,),
              Text("Ingridients",style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary
              ),
              ),
              const SizedBox(height: 14,),
               for(final ingredient in meal.ingredients )
                Text(ingredient,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground
                ),),
                const SizedBox(height: 24),
                Text("Steps",style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary
              ),),
              const SizedBox(height: 14,),
              for(final step in meal.steps )
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                  child: Text(
                    step,textAlign:TextAlign.center,  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                  ),),
                ),
            ],
          ),
        ));
  }
}
