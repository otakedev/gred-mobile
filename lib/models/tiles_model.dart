import 'package:flutter/material.dart';

class TileModel {
  final String leading;
  final String title;
  final String subtitle;

  TileModel({@required this.leading, @required this.title, this.subtitle})
      : assert(leading != null),
        assert(title != null);

  TileModel.fromMap(Map<String, dynamic> json)
      : leading = json['leading'],
        title = json['title'],
        subtitle = json['subtitle'];

  Map<String, dynamic> toMap() => {
        "leading": leading,
        "title": title,
        "subtitle": subtitle,
      };
}
