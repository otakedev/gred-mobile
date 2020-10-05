import 'package:flutter/material.dart';
import 'package:gred_mobile/models/recipe_model.dart';
import 'package:gred_mobile/providers/recipe_provider.dart';
import 'package:gred_mobile/screens/recipe-page/components/recipe.dart';
import 'package:provider/provider.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<RecipeProvider, List<RecipeModel>>(
      selector: (_, provider) => provider.recipes,
      builder: (context, recipes, _) => Recipe(recipes[0]),
    );
  }
}
