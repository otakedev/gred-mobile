import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gred_mobile/components/video_holder.dart';
import 'package:gred_mobile/models/recipe_help_model.dart';
import 'package:gred_mobile/providers/recipe_step_provider.dart';
import 'package:provider/provider.dart';

class HelpDialog extends StatelessWidget {
  HelpDialog(this._currentStep, {Key key}) : super(key: key);
  final int _currentStep;

  @override
  Widget build(BuildContext context) {
    var recipeHelp = context.select<RecipeStepProvider, RecipeHelpModel>(
      (provider) => provider.findByIndex(_currentStep).help,
    );

    return recipeHelp != null
        ? AlertDialog(
            title: Text(recipeHelp.title),
            content: Column(
              children: [
                VideoHolder(
                    source: recipeHelp.videoSource,
                    looping: false,
                    showControls: true),
                Text(recipeHelp.content),
              ],
            ),
          )
        : SizedBox.shrink();
  }
}
