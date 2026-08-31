import 'package:flutter/material.dart';

import 'home_page.dart';
import 'camera_page.dart';
import 'menu_page.dart';

void main() {
  runApp(
    const FridgeChefApp(),
  );
}

class FridgeChefApp extends StatelessWidget {
  const FridgeChefApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: "FridgeChef",

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
      ),

      // 最初に表示する画面
      home: const HomePage(),

      routes: {
        "/camera": (context) => const CameraPage(),
        "/menu": (context) => const MenuPage(),
      },
    );
  }
}
