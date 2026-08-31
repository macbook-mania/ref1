import 'dart:typed_data';

import 'package:google_generative_ai/google_generative_ai.dart';

class AIService {
  Future<String> analyzeImage(Uint8List bytes) async {
    final model = GenerativeModel(
      model: "gemini-3.6-flash",
      apiKey: const String.fromEnvironment(
        'AQ.Ab8RN6K_wcoKD7yIVFhLyTK1sRcJ0NNg1zCU6qjNs9mTKiyE8A',
      ),
    );

    const prompt = """
あなたは料理アシスタントAIです。

冷蔵庫の画像を解析してください。

画像から確認できる食材を判断し、
その食材を使った料理を1つ提案してください。

必ず以下の形式で日本語で回答してください。

【検出した食材】
・食材名
・食材名

【おすすめ料理】
料理名

【必要な材料】
・材料
・材料

【作り方】
① 手順
② 手順
③ 手順
④ 手順

料理初心者でも分かるように、
簡単で具体的に説明してください。

食品ロスを減らすため、
できるだけ冷蔵庫内の食材を活用してください。
""";

    final response = await model.generateContent([
      Content.multi([
        TextPart(prompt),
        DataPart(
          "image/jpeg",
          bytes,
        ),
      ]),
    ]);

    return response.text ?? "AIから回答を取得できませんでした。";
  }
}
