import 'package:flutter/material.dart';
import 'package:gred_mobile/providers/recipe_provider.dart';
import 'package:gred_mobile/providers/recipe_step_provider.dart';
import 'package:gred_mobile/providers/speech_provider.dart';
import 'package:gred_mobile/screens/recipe-list-page/recipe_list_page.dart';
import 'package:gred_mobile/screens/recipe-page/recipe-step-page/recipe_step_page.dart';
import 'package:gred_mobile/screens/recipe-page/recipe_page.dart';
import 'package:gred_mobile/screens/vocal-dialog-page/vocal_page.dart';
import 'package:gred_mobile/theme/style.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecipeProvider()),
        ChangeNotifierProvider(create: (_) => SpeechProvider()),
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
    return MaterialApp(
      title: 'Gred App',
      theme: appTheme(),
      initialRoute: '/recipes',
      routes: {
        '/recipes': (context) => RecipeListPage(),
        '/recipe': (context) => RecipePage(),
        '/steps': (context) => RecipeStepPage(),
        '/vocal-dialog': (context) => VocalPage(),
      },
    );
  }
}
