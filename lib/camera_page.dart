import 'package:flutter/material.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("冷蔵庫撮影"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            "パソコン版ではカメラ機能は利用できません。\n\n"
            "ホーム画面の\n"
            "「エクスプローラーから写真を選択」\n"
            "をご利用ください。",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.home),
      ),
    );
  }
}
