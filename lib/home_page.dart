import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'analysis_page.dart';
import 'camera_page.dart';
import 'menu_page.dart';
import 'recipes.dart';
import 'recipe_detail_page.dart';
import 'favorite_page.dart';
import 'history_page.dart';
import 'my_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      final bytes = await image.readAsBytes();

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AnalysisPage(
            imageBytes: bytes,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FridgeChef"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.kitchen,
                    size: 70,
                    color: Colors.green,
                  ),
                  SizedBox(height: 15),
                  Text(
                    "冷蔵庫の食材から\nAIが料理を提案",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.camera_alt),
                label: const Text(
                  "冷蔵庫を撮影する",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CameraPage(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.photo_library),
                label: const Text(
                  "エクスプローラーから写真を選択",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: pickImage,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.search),
                label: const Text(
                  "レシピを検索する",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MenuPage(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "✨ おすすめレシピ",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ...recipes.keys.take(3).map((name) {
              return Card(
                margin: const EdgeInsets.only(bottom: 15),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      recipes[name]!["image"]!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    "⏱ ${recipes[name]!["time"]}\n🔥 ${recipes[name]!["calorie"]}",
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RecipeDetailPage(
                          recipeName: name,
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "検索",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "お気に入り",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "履歴",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "マイページ",
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MenuPage(),
                ),
              );
              break;

            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FavoritePage(),
                ),
              );
              break;

            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const HistoryPage(),
                ),
              );
              break;

            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MyPage(),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}
