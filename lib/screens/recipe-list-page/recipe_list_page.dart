import 'package:flutter/material.dart';
import 'package:gred_mobile/models/recipe_model.dart';
import 'package:gred_mobile/providers/recipe_provider.dart';
import 'package:gred_mobile/screens/recipe-list-page/components/recipe_card.dart';
import 'package:provider/provider.dart';

class RecipeListPage extends StatefulWidget {
  RecipeListPage({Key key}) : super(key: key);

  @override
  _RecipeListPageState createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  List<RecipeModel> recipeList;

  @override
  Widget build(BuildContext context) {
    recipeList = context.select<RecipeProvider, List<RecipeModel>>(
        (provider) => provider.recipes);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Recettes'),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: recipeList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => selectAndOpen(context, index),
            child: RecipeCard(
                avatarUrl: recipeList[index].avatarUrl,
                author: recipeList[index].author,
                difficulty: recipeList[index].difficulty,
                imageUrl: recipeList[index].imageUrl,
                title: recipeList[index].title),
          );
        },
      ),
    );
  }

  void selectAndOpen(BuildContext context, int index) {
    context.read<RecipeProvider>().selectRecipe(index);
    Navigator.pushNamed(context, '/recipe');
  }
}
