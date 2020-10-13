import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gred_mobile/models/recipe_step_model.dart';
import 'package:gred_mobile/providers/recipe_step_provider.dart';
import 'package:gred_mobile/screens/recipe-page/components/recipe_list.dart';
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

    return Container(child: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      return Container(
          child: AlertDialog(
              title: Orientation.portrait == orientation
                  ? Column(children: [
                      StepTracker(currentStep: _currentStep, size: size),
                      TimeTracker(items: items, currentStep: _currentStep)
                    ])
                  : Row(children: [
                      StepTracker(currentStep: _currentStep, size: size),
                      Spacer(),
                      TimeTracker(items: items, currentStep: _currentStep)
                    ]),
              content: Container(
                  width: double.maxFinite,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index >= _currentStep) {
                          return Column(children: [
                            Row(children: [
                              Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: CircleAvatar(
                                    child: Text(index.toString(),
                                        style: TextStyle(color: kColorWhite)),
                                    backgroundColor: index == _currentStep
                                        ? kColorPrimary
                                        : kColorSecondary,
                                  )),
                              Expanded(
                                  child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(items[index].title,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: index == _currentStep
                                                  ? kColorPrimary
                                                  : kColorSecondary))))
                            ]),
                            RecipeList(
                                tiles: items[index].ingredients,
                                direction: orientation == Orientation.portrait
                                    ? Axis.vertical
                                    : Axis.horizontal)
                          ]);
                        } else {
                          return SizedBox.shrink();
                        }
                      }))));
    }));
  }
}

class TimeTracker extends StatelessWidget {
  const TimeTracker({Key key, @required this.items, @required int currentStep})
      : _currentStep = currentStep,
        super(key: key);

  final List<RecipeStepModel> items;
  final int _currentStep;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            style: TextStyle(
                color: kColorSecondary,
                fontSize: 20,
                fontWeight: FontWeight.bold),
            children: <TextSpan>[
          TextSpan(
              text:
                  items[_currentStep].overallRemainingTimeFromHere.toString() +
                      ' min',
              style: TextStyle(color: kColorAccent)),
          TextSpan(text: " restant estimée")
        ]));
  }
}

class StepTracker extends StatelessWidget {
  const StepTracker({Key key, @required int currentStep, @required this.size})
      : _currentStep = currentStep,
        super(key: key);

  final int _currentStep;
  final int size;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            style: TextStyle(
                color: kColorSecondary,
                fontSize: 24,
                fontWeight: FontWeight.bold),
            children: <TextSpan>[
          TextSpan(text: 'Étapes '),
          TextSpan(
              text: _currentStep.toString() + '/' + size.toString(),
              style: TextStyle(color: kColorPrimary))
        ]));
  }
}
