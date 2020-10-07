import 'package:flutter/cupertino.dart';

class RecipeStepModel {
  final String imageUrl;
  final String title;
  final String description;

  RecipeStepModel({
    @required this.imageUrl,
    @required this.title,
    @required this.description,
  })  : assert(imageUrl != null),
        assert(title != null),
        assert(description != null);

  RecipeStepModel.fromMap(Map<String, dynamic> json)
      : imageUrl = json['imageUrl'],
        title = json['title'],
        description = json['description'];

  Map<String, dynamic> toMap() => {
        "imageUrl": imageUrl,
        "title": title,
        "description": description,
      };
}
