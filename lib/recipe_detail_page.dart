import 'package:flutter/material.dart';

import 'favorites.dart';
import 'history.dart';
import 'recipes.dart';

class RecipeDetailPage extends StatefulWidget {
  final String recipeName;

  const RecipeDetailPage({
    super.key,
    required this.recipeName,
  });

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  @override
  void initState() {
    super.initState();

    // 履歴へ追加
    if (!historyRecipes.contains(widget.recipeName)) {
      historyRecipes.insert(
        0,
        widget.recipeName,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final recipe = recipes[widget.recipeName]!;

    final isFavorite = favoriteRecipes.contains(widget.recipeName);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipeName),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.star : Icons.star_border,
              color: Colors.yellow,
            ),
            onPressed: () {
              setState(() {
                if (isFavorite) {
                  favoriteRecipes.remove(
                    widget.recipeName,
                  );
                } else {
                  favoriteRecipes.add(
                    widget.recipeName,
                  );
                }
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 料理写真

            if (recipe["image"] != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  recipe["image"]!,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),

            const SizedBox(height: 20),

            Text(
              widget.recipeName,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "⏱ 調理時間：${recipe["time"] ?? ""}",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "🔥 カロリー：${recipe["calorie"] ?? ""}",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "🥕 材料",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              recipe["ingredients"] ?? "",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "👨‍🍳 作り方",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              recipe["howto"] ?? "",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
