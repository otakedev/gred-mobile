import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gred_mobile/models/recipe_step_model.dart';
import 'package:gred_mobile/providers/recipe_step_provider.dart';
import 'package:gred_mobile/theme/colors.dart';
import 'package:provider/provider.dart';

class StepTrakingDialog extends StatelessWidget {
  const StepTrakingDialog(this._currentStep, {Key key}) : super(key: key);
  final int _currentStep;

  @override
  Widget build(BuildContext context) {
    var items = context.select<RecipeStepProvider, List<RecipeStepModel>>(
      (provider) => provider.steps,
    );

    var size = items.length - 1;

    //TODO adapt view in landscape mode
    return Container(
        child: AlertDialog(
            title: Column(
              children: [
                RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: kColorSecondary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                      TextSpan(text: 'Étapes '),
                      TextSpan(
                          text: _currentStep.toString() + '/' + size.toString(),
                          style: TextStyle(color: kColorPrimary)),
                    ])),
                RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: kColorSecondary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                      TextSpan(
                          text: items[_currentStep]
                                  .overallRemainingTimeFromHere
                                  .toString() +
                              ' min',
                          style: TextStyle(color: kColorAccent)),
                      TextSpan(text: " restant estimée")
                    ])),
              ],
            ),
            content: Container(
                width: double.maxFinite,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index >= _currentStep) {
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: CircleAvatar(
                                child: Text(
                                  index.toString(),
                                  style: TextStyle(color: kColorWhite),
                                ),
                                backgroundColor: index == _currentStep
                                    ? kColorPrimary
                                    : kColorSecondary,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(items[index].title),
                            )
                          ],
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    }))));
  }
}
