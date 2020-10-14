import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gred_mobile/components/video_holder.dart';
import 'package:gred_mobile/core/text_style.dart';
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
        ? OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              return AlertDialog(
                scrollable: true,
                title: Text(recipeHelp.title),
                content: orientation == Orientation.portrait
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          VideoHolder(
                            source: recipeHelp.videoSource,
                            looping: false,
                            showControls: true,
                            styleIsMaterial: false,
                          ),
                          SizedBox(height: 10),
                          Text(recipeHelp.content, style: bodyText2(context)),
                        ],
                      )
                    : Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: VideoHolder(
                              source: recipeHelp.videoSource,
                              looping: false,
                              showControls: true,
                              styleIsMaterial: false,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 8, 8),
                              child: Text(
                                recipeHelp.content,
                                style: bodyText1(context),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        ],
                      ),
              );
            },
          )
        : SizedBox.shrink();
  }
}
