import 'package:flutter/material.dart';
import 'package:gred_mobile/models/recipe_model.dart';
import 'package:gred_mobile/providers/recipe_provider.dart';
import 'package:gred_mobile/screens/recipe-page/recipe-step-page/components/recipe_steps.dart';
import 'package:provider/provider.dart';

class RecipeStepPage extends StatelessWidget {
  const RecipeStepPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var recipe = context.select<RecipeProvider, RecipeModel>(
      (provider) => provider.selectedRecipe,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('${recipe?.title ?? "Recipe"}'),
      ),
      body: RecipeSteps(),
    );
  }
}
