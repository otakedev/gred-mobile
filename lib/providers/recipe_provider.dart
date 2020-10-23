import 'package:flutter/material.dart';
import 'package:gred_mobile/mocks/recipe_mock.dart';
import 'package:gred_mobile/models/recipe_model.dart';
import 'package:gred_mobile/models/tiles_model.dart';

class RecipeProvider extends ChangeNotifier {
  final List<RecipeModel> _recipes =
      RECIPES_MOCK.map((model) => RecipeModel.fromMap(model)).toList();

  // not used for now
  RecipeModel _recipe;

  List<RecipeModel> get recipes => _recipes;

  RecipeModel get selectedRecipe => _recipe;

  List<TileModel> get selectedRecipeIngredients => _recipe.steps
      .map((e) => e.ingredients)
      .toList()
      .expand((x) => x)
      .toList();

  set selectedRecipe(RecipeModel recipe) {
    _recipe = selectedRecipe;
    notifyListeners();
  }

  void selectRecipe(int index) {
    _recipe = _recipes[index];
    notifyListeners();
  }
}
