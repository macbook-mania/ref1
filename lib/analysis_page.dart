import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'ai_service.dart';
import 'favorites.dart';
import 'history.dart';

class AnalysisPage extends StatefulWidget {
  final Uint8List imageBytes;

  const AnalysisPage({
    super.key,
    required this.imageBytes,
  });

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  final AIService aiService = AIService();

  bool loading = true;

  String aiText = "";

  String recipeName = "";

  @override
  void initState() {
    super.initState();
    analyze();
  }

  Future<void> analyze() async {
    try {
      final result = await aiService.analyzeImage(
        widget.imageBytes,
      );

      if (!mounted) return;

      final name = extractRecipeName(result);

      setState(() {
        aiText = result;
        recipeName = name;

        if (name.isNotEmpty) {
          if (!historyRecipes.contains(name)) {
            historyRecipes.insert(0, name);
          }
        }

        loading = false;
      });
    } catch (e, stackTrace) {
      print("===== AI ERROR =====");
      print(e);
      print(stackTrace);

      setState(() {
        aiText = "AI解析に失敗しました。\n$e";
        loading = false;
      });
    }
  }

  String extractRecipeName(String text) {
    if (text.contains("【おすすめ料理】")) {
      final result = text.split("【おすすめ料理】")[1];
      return result.split("\n").first.trim();
    }

    return "AIおすすめ料理";
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = favoriteRecipes.contains(recipeName);

    return Scaffold(
      appBar: AppBar(
        title: const Text("AI献立提案"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.memory(
                      widget.imageBytes,
                      width: double.infinity,
                      height: 220,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Text(
                      "✨ AIおすすめ献立",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Text(
                        aiText,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.8,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      icon: Icon(
                        isFavorite ? Icons.star : Icons.star_border,
                      ),
                      label: Text(
                        isFavorite ? "お気に入り解除" : "お気に入り登録",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          if (isFavorite) {
                            favoriteRecipes.remove(recipeName);
                          } else {
                            favoriteRecipes.add(recipeName);
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.home),
                      label: const Text(
                        "ホームへ戻る",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
