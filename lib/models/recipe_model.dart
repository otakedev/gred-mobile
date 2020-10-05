import 'package:flutter/cupertino.dart';

class RecipeModel {
  final String imageUrl;
  final String avatarUrl;
  final int difficulty;
  final String title;
  final String description;
  final List<String> ingredients;
  final List<String> utensils;

  RecipeModel({
    @required this.imageUrl,
    @required this.avatarUrl,
    @required this.difficulty,
    @required this.title,
    @required this.description,
    @required this.ingredients,
    this.utensils,
  })  : assert(imageUrl != null),
        assert(avatarUrl != null),
        assert(difficulty != null),
        assert(title != null),
        assert(description != null),
        assert(ingredients != null);

  RecipeModel.fromMap(Map<String, dynamic> json)
      : imageUrl = json['imageUrl'],
        avatarUrl = json['avatarUrl'],
        difficulty = json['difficulty'],
        title = json['title'],
        description = json['description'],
        ingredients = json['ingredients'],
        utensils = json['utensils'];

  Map<String, dynamic> toMap() => {
        "imageUrl": imageUrl,
        "avatarUrl": avatarUrl,
        "difficulty": difficulty,
        "title": title,
        "description": description,
        "ingredients": ingredients,
        "utensils": utensils,
      };
}
