import 'package:flutter/material.dart';

import 'recipes.dart';
import 'recipe_detail_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String searchText = "";

  List<String> get filteredRecipes {
    if (searchText.isEmpty) {
      return recipes.keys.toList();
    }

    return recipes.keys
        .where(
          (recipe) => recipe.toLowerCase().contains(
                searchText.toLowerCase(),
              ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("レシピ検索"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: "料理名を入力",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredRecipes.length,
                itemBuilder: (context, index) {
                  final recipeName = filteredRecipes[index];
                  final recipe = recipes[recipeName]!;

                  return Card(
                    child: ListTile(
                      title: Text(recipeName),
                      subtitle: Text(
                        "${recipe["time"]}　${recipe["calorie"]}",
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RecipeDetailPage(
                              recipeName: recipeName,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
