import 'package:flutter/cupertino.dart';
import 'package:gred_mobile/models/recipe_help_model.dart';

class RecipeStepModel {
  final String imageUrl;
  final String title;
  final String description;
  final RecipeHelpModel help;

  RecipeStepModel({
    this.help,
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
        help = json.containsKey('help')
            ? RecipeHelpModel.fromMap(json['help'])
            : null;

  Map<String, dynamic> toMap() => {
        "imageUrl": imageUrl,
        "title": title,
        "description": description,
        "help": help
      };
}
