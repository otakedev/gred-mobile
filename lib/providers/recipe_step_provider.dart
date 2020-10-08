import 'package:flutter/material.dart';
import 'package:gred_mobile/models/recipe_step_model.dart';

class RecipeStepProvider extends ChangeNotifier {
  List<RecipeStepModel> _steps;

  List<RecipeStepModel> get steps => _steps;

  int get stepsCount => _steps.length;

  RecipeStepModel findByIndex(int i) => _steps[i];

  set steps(List<RecipeStepModel> steps) {
    _steps = steps;
    notifyListeners();
  }
}
