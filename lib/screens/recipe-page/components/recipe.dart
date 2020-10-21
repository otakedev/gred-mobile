import 'package:flutter/material.dart';
import 'package:gred_mobile/core/preference_access.dart';
import 'package:gred_mobile/core/text_style.dart';
import 'package:gred_mobile/models/recipe_model.dart';
import 'package:gred_mobile/providers/skill_adaptation_provider.dart';
import 'package:gred_mobile/screens/recipe-page/components/cook_level.dart';
import 'package:gred_mobile/screens/recipe-page/components/recipe_list.dart';
import 'package:gred_mobile/theme/colors.dart';
import 'package:provider/provider.dart';

class Recipe extends StatelessWidget {
  const Recipe(RecipeModel recipe, {Key key})
      : this.recipe = recipe,
        super(key: key);

  final RecipeModel recipe;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height *
        MediaQuery.of(context).devicePixelRatio;
    double width = MediaQuery.of(context).size.width *
        MediaQuery.of(context).devicePixelRatio;

    bool isWideScreenPortrait = height > 2000;
    bool isWideSceenLandscape = width > 2000;

    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
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
                padding: isWideSceenLandscape || isWideScreenPortrait
                    ? const EdgeInsets.all(20.0)
                    : const EdgeInsets.all(16.0),
                color: kColorWhite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(recipe.title, style: headline5(context)),
                    isWideSceenLandscape || isWideScreenPortrait
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(recipe.description,
                                style: bodyText1(context)),
                          )
                        : Text(recipe.description, style: bodyText2(context))
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RecipeList(
                  tiles: recipe.ingredients,
                  title: "Ingredients",
                  direction: orientation == Orientation.portrait
                      ? Axis.vertical
                      : Axis.horizontal,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RecipeList(
                    tiles: recipe.utensils,
                    title: "Ustensiles",
                    direction: orientation == Orientation.portrait
                        ? Axis.vertical
                        : Axis.horizontal),
              ),
              SizedBox(height: 20),

              // TODO Remove , this is for testing
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () => chooseNovice(),
                      child: Text("Novice"),
                      color: Colors.yellow,
                    ),
                    RaisedButton(
                      onPressed: () => {
                        chooseExpert(),
                        checkUserSkill().then((value) => {
                              if (value == "EXPERT")
                                {
                                  print(
                                      "RESETTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT"),
                                  context
                                      .read<SkillAdaptationProvider>()
                                      .resetHelpAsk()
                                }
                            })
                      },
                      child: Text("Expert"),
                      color: Colors.yellow,
                    )
                  ])
            ],
          ),
        );
      },
    );
  }
}
