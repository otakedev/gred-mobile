import 'package:flutter/widgets.dart';

class RecipeHelpModel {
  final String title;
  final String content;
  final String videoSource;
  final String videoTitle;

  RecipeHelpModel(
      {@required this.title,
      @required this.content,
      @required this.videoSource,
      @required this.videoTitle})
      : assert(title != null),
        assert(content != null),
        assert(videoSource != null),
        assert(videoTitle != null);

  RecipeHelpModel.fromMap(Map<String, dynamic> json)
      : title = json['title'],
        content = json['content'],
        videoSource = json['videoSource'],
        videoTitle = json['videoTitle'];

  Map<String, dynamic> toMap() => {
        "title": title,
        "content": content,
        "videoSource": videoSource,
        "videoTitle": videoTitle
      };
}
