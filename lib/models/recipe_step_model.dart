import 'package:flutter/cupertino.dart';
import 'package:gred_mobile/models/recipe_help_model.dart';
import 'package:gred_mobile/models/tiles_model.dart';

class RecipeStepModel {
  final String imageUrl;
  final String title;
  final String description;
  final List<TileModel> ingredients;
  final RecipeHelpModel help;
  final int timeEstimated;
  final int overallRemainingTimeFromHere;

  RecipeStepModel({
    this.help,
    this.ingredients,
    @required this.timeEstimated,
    @required this.overallRemainingTimeFromHere,
    @required this.imageUrl,
    @required this.title,
    @required this.description,
  })  : assert(imageUrl != null),
        assert(title != null),
        assert(description != null);

  RecipeStepModel.fromMap(Map<String, dynamic> json)
      : imageUrl = json['imageUrl'],
        title = json['title'],
        description = json['description'],
        ingredients = json['ingredients']
            .map<TileModel>(
              (i) => TileModel.fromMap(i),
            )
            .toList(),
        help = json.containsKey('help')
            ? RecipeHelpModel.fromMap(json['help'])
            : null,
        timeEstimated = json['timeEstimdated'],
        overallRemainingTimeFromHere = json['overallRemainingTimeFromHere'];

  Map<String, dynamic> toMap() => {
        "imageUrl": imageUrl,
        "title": title,
        "description": description,
        "help": help,
        "ingredients":
            List<RecipeStepModel>.from(ingredients.map((s) => s.toMap())),
        "timeEstimated": timeEstimated,
        "overallRemainingTimeFromHere": overallRemainingTimeFromHere
      };
}
