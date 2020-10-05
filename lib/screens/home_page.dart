import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gred_mobile/models/recipe_model.dart';
import 'package:gred_mobile/providers/recipe_provider.dart';
import 'package:gred_mobile/screens/recipe-page/recipe_page.dart';
import 'package:gred_mobile/theme/colors.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecipeProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Selector<RecipeProvider, RecipeModel>(
              selector: (_, provider) => provider.selectedRecipe,
              builder: (context, recipe, _) =>
                  Text('${recipe?.title ?? "Recipe"}')),
        ),
        body: RecipePage(),
        floatingActionButton: FloatingActionButton.extended(
          label: Text('Start Cooking !', style: TextStyle(color: kColorWhite)),
          backgroundColor: kColorPrimary,
          icon: FaIcon(FontAwesomeIcons.cookie, color: kColorWhite),
          onPressed: () {
            // Add action here
          },
        ),
      ),
    );
  }
}
