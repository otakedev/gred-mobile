import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gred_mobile/core/text_style.dart';
import 'package:gred_mobile/models/recipe_model.dart';
import 'package:gred_mobile/providers/recipe_provider.dart';
import 'package:gred_mobile/providers/recipe_step_provider.dart';
import 'package:gred_mobile/providers/speech_provider.dart';
import 'package:gred_mobile/screens/recipe-page/components/recipe.dart';
import 'package:gred_mobile/theme/colors.dart';
import 'package:gred_mobile/theme/style.dart';
import 'package:provider/provider.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var recipe = context.select<RecipeProvider, RecipeModel>(
      (provider) => provider.selectedRecipe,
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${recipe?.title ?? "Recipe"}'),
      ),
      body: Recipe(recipe),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Commencer à cuisiner !', style: headline6White(context)),
        backgroundColor: kColorPrimary,
        icon: FaIcon(
          FontAwesomeIcons.cookie,
          color: kColorWhite,
          size: 20 + offset,
        ),
        onPressed: () {
          if (context.read<RecipeStepProvider>().isVocalEnabled) {
            Navigator.pushNamed(context, '/vocal-dialog');
          } else {
            context.read<SpeechProvider>().restoreLastState();
            Navigator.pushNamed(context, '/steps');
          }
        },
      ),
    );
  }
}
