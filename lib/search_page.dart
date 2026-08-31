import 'package:flutter/material.dart';

import 'recipe_detail_page.dart';
import 'recipe_search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String keyword = "";

  @override
  Widget build(BuildContext context) {
    final results = RecipeSearch.search(keyword);

    return Scaffold(
      appBar: AppBar(
        title: const Text("レシピ検索"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(
                hintText: "料理名・食材を入力",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  keyword = value;
                });
              },
            ),
          ),
          Expanded(
            child: results.isEmpty
                ? const Center(
                    child: Text(
                      "該当するレシピがありません",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final recipeName = results[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.restaurant_menu),
                          title: Text(recipeName),
                          trailing: const Icon(Icons.arrow_forward_ios),
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
    );
  }
}
