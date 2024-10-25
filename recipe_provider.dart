// lib/recipe_provider.dart
import 'package:flutter/material.dart';
import 'recipe.dart'; // Import the Recipe model

class RecipeProvider extends ChangeNotifier {
  List<Recipe> _recipes = []; // Internal list of recipes

  // Getter to expose the list of recipes
  List<Recipe> get recipes => _recipes;

  // Method to add a recipe
  void addRecipe(String title, String description) {
    _recipes.add(Recipe(title: title, description: description));
    notifyListeners(); // Notify listeners about the change
  }

  // Method to remove a recipe by index
  void removeRecipe(int index) {
    _recipes.removeAt(index);
    notifyListeners(); // Notify listeners about the change
  }
}
