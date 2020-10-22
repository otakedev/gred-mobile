import 'package:flutter/material.dart';
import 'package:gred_mobile/providers/recipe_provider.dart';
import 'package:gred_mobile/providers/recipe_step_provider.dart';
import 'package:gred_mobile/providers/skill_adaptation_provider.dart';
import 'package:gred_mobile/providers/speech_provider.dart';
import 'package:gred_mobile/screens/recipe-list-page/recipe_list_page.dart';
import 'package:gred_mobile/screens/recipe-page/recipe-step-page/recipe_step_page.dart';
import 'package:gred_mobile/screens/recipe-page/recipe_page.dart';
import 'package:gred_mobile/screens/starting_page.dart';
import 'package:gred_mobile/screens/vocal-dialog-page/vocal_page.dart';
import 'package:gred_mobile/theme/style.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecipeProvider()),
        ChangeNotifierProvider(create: (_) => SpeechProvider()),
        ChangeNotifierProvider(create: (_) => SkillAdaptationProvider()),
        ChangeNotifierProxyProvider<RecipeProvider, RecipeStepProvider>(
          create: (context) => RecipeStepProvider(),
          update: (context, from, to) {
            to.steps = from.selectedRecipe.steps;
            return to;
          },
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return MaterialApp(
        title: 'Gred App',
        theme: constraints.maxWidth > 1000 || constraints.maxHeight > 1000
            ? (constraints.maxWidth > 1600 || constraints.maxHeight > 1600
                ? appTheme(fontOffset: 20)
                : appTheme(fontOffset: 10))
            : appTheme(),
        initialRoute: '/start',
        routes: {
          '/recipes': (context) => RecipeListPage(),
          '/recipe': (context) => RecipePage(),
          '/steps': (context) => RecipeStepPage(),
          '/vocal-dialog': (context) => VocalPage(),
          '/start': (context) => StartingPage(),
        },
      );
    });
  }
}
