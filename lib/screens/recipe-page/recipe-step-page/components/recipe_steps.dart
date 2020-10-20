import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gred_mobile/components/microphone.dart';
import 'package:gred_mobile/core/preference_access.dart';
import 'package:gred_mobile/models/recipe_step_model.dart';
import 'package:gred_mobile/providers/recipe_step_provider.dart';
import 'package:gred_mobile/providers/speech_provider.dart';
import 'package:gred_mobile/screens/recipe-page/recipe-step-page/components/help_dialog.dart';
import 'package:gred_mobile/screens/recipe-page/recipe-step-page/components/recipe_step.dart';
import 'package:gred_mobile/screens/recipe-page/recipe-step-page/components/step_tracking_dialog.dart';
import 'package:gred_mobile/theme/colors.dart';
import 'package:provider/provider.dart';

class RecipeSteps extends StatefulWidget {
  const RecipeSteps({Key key}) : super(key: key);

  @override
  _RecipeStepsState createState() => _RecipeStepsState();
}

class _RecipeStepsState extends State<RecipeSteps> {
  int _currentPage = 0;
  bool _isHelpVisible = true;
  bool _isVocalInAction = false;
  List<RecipeStepModel> _recipes;

  PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
  }

  void _onPageViewChange(int page) {
    setState(() {
      _currentPage = page;
      _isHelpVisible = _recipes[page].help != null;
    });
  }

  int Function() _previousPage() {
    return () => _currentPage - 1;
  }

  int Function() _nextPage() {
    return () => _currentPage + 1;
  }

  void Function() _updatePage(int Function() fn) =>
      () => _controller.animateToPage(
            fn(),
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget stepButton(
    IconData icon,
    void Function() onPressed, {
    style = ButtonTextTheme.primary,
    color = kColorPrimary,
    iconColor = kColorWhite,
    visible = true,
  }) =>
      Visibility(
        maintainState: true,
        maintainAnimation: true,
        maintainSize: true,
        visible: visible,
        child: ButtonTheme(
          minWidth: 50.0,
          height: 50.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: RaisedButton(
            color: color,
            textTheme: style,
            onPressed: onPressed,
            child: Icon(icon, size: 40, color: iconColor),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    var itemsCount = context.select<RecipeStepProvider, int>(
      (provider) => provider.stepsCount,
    );

    _recipes = context.select<RecipeStepProvider, List<RecipeStepModel>>(
      (provider) => provider.steps,
    );

    context.select<SpeechProvider, Command>((provider) {
      // I call that DIY
      if (_isVocalInAction == true) {
        return provider.command;
      }
      _isVocalInAction = true;
      Timer(Duration(milliseconds: 500), () => _isVocalInAction = false);
      if (provider.command == Command.NEXT) {
        _updatePage(_nextPage())();
      } else if (provider.command == Command.PREVIOUS) {
        _updatePage(_previousPage())();
      }
      return provider.command;
    });

    return Stack(
      children: [
        PageView.builder(
          controller: _controller,
          onPageChanged: _onPageViewChange,
          itemCount: itemsCount,
          itemBuilder: (context, position) => Stack(
            children: [
              LinearProgressIndicator(
                value: (_currentPage + 1) / itemsCount,
                minHeight: 8,
              ),
              RecipeStep(position),
            ],
          ),
        ),
        Positioned(
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  stepButton(
                    Icons.arrow_back,
                    _updatePage(_previousPage()),
                    visible: _currentPage > 0,
                  ),
                  stepButton(
                    Icons.menu_book_rounded,
                    trackStepDialog(context),
                    color: kColorSecondary,
                  ),
                  if (_isHelpVisible)
                    FutureBuilder(
                        future: checkUserSkill(),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasData) {
                            return stepButton(
                              Icons.help_outline,
                              helpDialog(context),
                              iconColor: snapshot.data == "NOVICE"
                                  ? kColorSecondary
                                  : kColorWhite,
                              color: snapshot.data == "NOVICE"
                                  ? kColorAccent
                                  : kColorSecondary,
                            );
                          } else
                            return SizedBox.shrink();
                        }),
                  stepButton(
                    Icons.arrow_forward,
                    _updatePage(_nextPage()),
                    visible: _currentPage < itemsCount - 1,
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment:
              Alignment.lerp(Alignment.topLeft, Alignment.bottomLeft, 0.30),
          child: Selector<SpeechProvider, bool>(
            selector: (_, model) => model.isActive,
            shouldRebuild: (prev, next) => next != prev,
            builder: (context, value, _) => Microphone(
              isListening: value,
              onTap: () => {
                context.read<SpeechProvider>().switchListeningMode(),
              },
            ),
          ),
        )
      ],
    );
  }

  void Function() helpDialog(BuildContext context) {
    return () =>
        showDialog(context: context, builder: (_) => HelpDialog(_currentPage));
  }

  void Function() trackStepDialog(BuildContext context) {
    return () => showDialog(
        context: context, builder: (_) => StepTrackingDialog(_currentPage));
  }
}
