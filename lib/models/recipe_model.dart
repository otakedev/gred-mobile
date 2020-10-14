import 'package:flutter/cupertino.dart';
import 'package:gred_mobile/models/recipe_step_model.dart';
import 'package:gred_mobile/models/tiles_model.dart';

class RecipeModel {
  final String imageUrl;
  final String avatarUrl;
  final String author;
  final int difficulty;
  final String title;
  final String description;
  final List<TileModel> utensils;
  final List<RecipeStepModel> steps;

  RecipeModel({
    @required this.imageUrl,
    @required this.avatarUrl,
    @required this.author,
    @required this.difficulty,
    @required this.title,
    @required this.description,
    @required this.steps,
    this.utensils,
  })  : assert(imageUrl != null),
        assert(author != null),
        assert(avatarUrl != null),
        assert(difficulty != null),
        assert(title != null),
        assert(description != null),
        assert(steps != null);

  List<TileModel> get ingredients =>
      steps.map((e) => e.ingredients).toList().expand((x) => x).toList();

  RecipeModel.fromMap(Map<String, dynamic> json)
      : imageUrl = json['imageUrl'],
        avatarUrl = json['avatarUrl'],
        author = json['author'],
        difficulty = json['difficulty'],
        title = json['title'],
        description = json['description'],
        steps = json['steps']
            .map<RecipeStepModel>(
              (model) => RecipeStepModel.fromMap(model),
            )
            .toList(),
        utensils = json['utensils']
            .map<TileModel>(
              (i) => TileModel.fromMap(i),
            )
            .toList();

  Map<String, dynamic> toMap() => {
        "imageUrl": imageUrl,
        "avatarUrl": avatarUrl,
        "author": author,
        "difficulty": difficulty,
        "title": title,
        "description": description,
        "steps": List<RecipeStepModel>.from(steps.map((s) => s.toMap())),
        "utensils": utensils,
      };
}
