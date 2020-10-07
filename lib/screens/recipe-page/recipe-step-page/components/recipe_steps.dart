import 'package:flutter/material.dart';
import 'package:gred_mobile/providers/recipe_step_provider.dart';
import 'package:gred_mobile/screens/recipe-page/recipe-step-page/components/recipe_step.dart';
import 'package:provider/provider.dart';

class RecipeSteps extends StatefulWidget {
  const RecipeSteps({Key key}) : super(key: key);

  @override
  _RecipeStepsState createState() => _RecipeStepsState();
}

class _RecipeStepsState extends State<RecipeSteps> {
  int _currentPage = 0;

  PageController _controller = PageController(initialPage: 0);

  void _onPageViewChange(int page) {
    _currentPage = page;
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
            curve: Curves.linear,
          );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget stepButton(IconData icon, void Function() onPressed,
          {style = ButtonTextTheme.primary}) =>
      RaisedButton(
        textTheme: style,
        onPressed: onPressed,
        child: Icon(icon, size: 40),
      );

  @override
  Widget build(BuildContext context) {
    var itemsCount = context.select<RecipeStepProvider, int>(
      (provider) => provider.stepsCount,
    );

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
                  stepButton(Icons.arrow_back, _updatePage(_previousPage())),
                  stepButton(Icons.arrow_forward, _updatePage(_nextPage())),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
