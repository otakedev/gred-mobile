import 'package:flutter/material.dart';
import 'package:gred_mobile/core/global_key.dart';
import 'package:gred_mobile/models/recipe_model.dart';
import 'package:gred_mobile/providers/recipe_provider.dart';
import 'package:gred_mobile/providers/speech_provider.dart';
import 'package:gred_mobile/screens/recipe-page/recipe-step-page/components/recipe_steps.dart';
import 'package:gred_mobile/theme/colors.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

class RecipeStepPage extends StatelessWidget {
  const RecipeStepPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var recipe = context.select<RecipeProvider, RecipeModel>(
      (provider) => provider.selectedRecipe,
    );

    return Scaffold(
      key: scaffoldVocalDialogKey,
      appBar: AppBar(
          centerTitle: true,
          title: Text('${recipe?.title ?? "Recipe"}'),
          leading: Container(
            decoration: BoxDecoration(
              color: kColorSecondary,
              borderRadius: BorderRadius.only(topRight: Radius.circular(30)),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: kColorWhite),
              onPressed: () => {
                context.read<SpeechProvider>().stopListening(),
                Navigator.pop(context),
                Wakelock.disable()
              },
            ),
          )),
      body: RecipeSteps(),
    );
  }
}
