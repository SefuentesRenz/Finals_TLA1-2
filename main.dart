// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers.dart'; // Ensure this is named correctly

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: RecipeScreen(),
    );
  }
}

class RecipeScreen extends ConsumerStatefulWidget {
  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends ConsumerState<RecipeScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final recipeProviderInstance =
        ref.watch(recipeProvider); // Access the RecipeProvider instance

    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: recipeProviderInstance
                  .recipes.length, // Access recipes from the instance
              itemBuilder: (context, index) {
                final recipe = recipeProviderInstance.recipes[index];
                return ListTile(
                  title: Text(recipe.title),
                  subtitle: Text(recipe.description),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      ref
                          .read(recipeProvider)
                          .removeRecipe(index); // Remove recipe
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: 'Recipe Title'),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    final title = titleController.text;
                    final description = descriptionController.text;

                    if (title.isNotEmpty && description.isNotEmpty) {
                      ref
                          .read(recipeProvider)
                          .addRecipe(title, description); // Add recipe
                      titleController.clear();
                      descriptionController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose(); // Dispose controllers
    descriptionController.dispose();
    super.dispose();
  }
}
