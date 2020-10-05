import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gred_mobile/mocks/recipe_mock.dart';
import 'package:gred_mobile/models/recipe_model.dart';

class RecipeProvider extends ChangeNotifier {
  final List<RecipeModel> _recipes =
      RECIPES_MOCK.map((model) => RecipeModel.fromMap(model)).toList();

  RecipeModel _recipe;

  List<RecipeModel> get recipes => _recipes;

  RecipeModel get selectedRecipe => _recipe;

  set selectedRecipe(RecipeModel recipe) {
    _recipe = selectedRecipe;
    notifyListeners();
  }
}
