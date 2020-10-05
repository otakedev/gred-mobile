import 'package:flutter/material.dart';
import 'package:gred_mobile/core/text_style.dart';
import 'package:gred_mobile/models/recipe_model.dart';
import 'package:gred_mobile/screens/recipe-page/components/cook_level.dart';
import 'package:gred_mobile/theme/colors.dart';

class Recipe extends StatelessWidget {
  const Recipe(RecipeModel recipe, {Key key})
      : this.recipe = recipe,
        super(key: key);

  final RecipeModel recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(recipe.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CookLevel(level: recipe.difficulty),
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 53,
                      backgroundColor: kColorWhite,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(recipe.avatarUrl),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            color: kColorWhite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(recipe.title, style: headline5(context)),
                Text(recipe.description, style: bodyText2(context))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: kColorWhite,
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Ingredients", style: headline6(context)),
                    for (var i in recipe.ingredients)
                      Text('- $i', style: TextStyle(height: 1.5)),
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: kColorWhite,
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Ustensiles", style: headline6(context)),
                  for (var i in recipe.utensils)
                    Text('- $i', style: TextStyle(height: 1.5)),
                ],
              ),
            ),
          ),
          SizedBox(height: 100)
        ],
      ),
    );
  }
}
