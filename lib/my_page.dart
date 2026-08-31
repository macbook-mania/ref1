import 'package:flutter/material.dart';

import 'favorites.dart';
import 'history.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("マイページ"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 45,
              backgroundColor: Colors.green,
              child: Icon(
                Icons.kitchen,
                size: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "FridgeChef",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "AI冷蔵庫献立アプリ",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 30),
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                title: const Text(
                  "お気に入り",
                ),
                trailing: Text(
                  "${favoriteRecipes.length}件",
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.history,
                ),
                title: const Text(
                  "閲覧履歴",
                ),
                trailing: Text(
                  "${historyRecipes.length}件",
                ),
              ),
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "アプリについて",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "FridgeChefは、冷蔵庫の食材をAIが分析し、"
                      "家庭にある食材からおすすめ料理を提案するアプリです。\n\n"
                      "食品ロス削減や料理初心者のサポートを目的としています。",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
