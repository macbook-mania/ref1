import 'recipes.dart';

class RecipeSearch {
  static List<String> search(String keyword) {
    if (keyword.trim().isEmpty) {
      return recipes.keys.toList();
    }

    final lowerKeyword = keyword.toLowerCase();

    return recipes.keys.where((recipeName) {
      final recipe = recipes[recipeName]!;

      // 料理名検索
      if (recipeName.toLowerCase().contains(lowerKeyword)) {
        return true;
      }

      // 材料検索
      final ingredients = recipe["ingredients"].toString().toLowerCase();

      if (ingredients.contains(lowerKeyword)) {
        return true;
      }

      // 作り方検索
      final howto = recipe["howto"].toString().toLowerCase();

      if (howto.contains(lowerKeyword)) {
        return true;
      }

      return false;
    }).toList();
  }
}
