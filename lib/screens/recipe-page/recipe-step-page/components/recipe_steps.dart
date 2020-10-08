import 'package:flutter/material.dart';
import 'package:gred_mobile/core/preference_access.dart';
import 'package:gred_mobile/models/recipe_step_model.dart';
import 'package:gred_mobile/providers/recipe_provider.dart';
import 'package:gred_mobile/providers/recipe_step_provider.dart';
import 'package:gred_mobile/screens/recipe-page/recipe-step-page/components/help_dialog.dart';
import 'package:gred_mobile/screens/recipe-page/recipe-step-page/components/recipe_step.dart';
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
  List<RecipeStepModel> recipes;

  PageController _controller = PageController();

  void _onPageViewChange(int page) {
    setState(() {
      _currentPage = page;
      _isHelpVisible = recipes[page].help != null;
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

  Widget stepButton(IconData icon, void Function() onPressed,
          {style = ButtonTextTheme.primary,
          color: kColorPrimary,
          visible = true}) =>
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
            child: Icon(icon, size: 40),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    var itemsCount = context.select<RecipeStepProvider, int>(
      (provider) => provider.stepsCount,
    );

    recipes = context.select<RecipeStepProvider, List<RecipeStepModel>>(
        (provider) => provider.steps);

    return Stack(
      children: [
        PageView.builder(
          controller: _controller,
          onPageChanged: _onPageViewChange,
          itemCount: itemsCount,
          itemBuilder: (context, position) => RecipeStep(position),
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
                    ingredientsDialog(context),
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
      ],
    );
  }

  void Function() helpDialog(BuildContext context) {
    return () =>
        showDialog(context: context, builder: (_) => HelpDialog(_currentPage));
  }

  void Function() ingredientsDialog(BuildContext context) {
    return () {
      var ingredients =
          context.read<RecipeProvider>().selectedRecipe.ingredients;
      showDialog(
        context: context,
        child: SimpleDialog(
          title: Text("Un oubli ?"),
          children: [
            for (var i in ingredients)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('- $i', style: TextStyle(height: 1.0)),
              ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "C'est bon ?",
                style: TextStyle(color: kColorPrimary),
              ),
            ),
          ],
        ),
      );
    };
  }
}
