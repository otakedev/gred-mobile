import 'package:flutter/widgets.dart';

class RecipeHelpModel {
  final String title;
  final String content;
  final String videoSource;

  RecipeHelpModel(
      {@required this.title,
      @required this.content,
      @required this.videoSource})
      : assert(title != null),
        assert(content != null),
        assert(videoSource != null);

  RecipeHelpModel.fromMap(Map<String, dynamic> json)
      : title = json['title'],
        content = json['content'],
        videoSource = json['videoSource'];

  Map<String, dynamic> toMap() =>
      {"title": title, "content": content, "videoSource": videoSource};
}
