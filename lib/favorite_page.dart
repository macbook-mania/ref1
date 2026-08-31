import 'package:flutter/material.dart';

import 'favorites.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("お気に入り"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: favoriteRecipes.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star_border,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "お気に入り登録した料理はありません",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: favoriteRecipes.length,
              itemBuilder: (context, index) {
                final recipeName = favoriteRecipes[index];

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(
                    bottom: 15,
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 35,
                    ),
                    title: Text(
                      recipeName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                      ),
                      onPressed: () {
                        setState(() {
                          favoriteRecipes.remove(recipeName);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
