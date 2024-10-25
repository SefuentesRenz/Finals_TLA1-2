// lib/providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'recipe_provider.dart'; // Import the RecipeProvider

// Create a ChangeNotifierProvider for the RecipeProvider
final recipeProvider = ChangeNotifierProvider<RecipeProvider>((ref) {
  return RecipeProvider();
});
