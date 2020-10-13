import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gred_mobile/core/text_style.dart';
import 'package:gred_mobile/models/tiles_model.dart';
import 'package:gred_mobile/theme/colors.dart';

class RecipeList extends StatelessWidget {
  const RecipeList(
      {Key key,
      this.title,
      @required this.tiles,
      this.displayImage = true,
      this.direction = Axis.vertical})
      : super(key: key);

  final String title;
  final Axis direction;
  final bool displayImage;
  final List<TileModel> tiles;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: kColorWhite,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: GredListTile(
          title: title,
          tiles: tiles,
          displayImage: displayImage,
          direction: direction),
    );
  }
}

class GredListTile extends StatelessWidget {
  const GredListTile({
    Key key,
    this.title,
    @required this.tiles,
    this.direction,
    this.displayImage,
  }) : super(key: key);

  final String title;
  final Axis direction;
  final bool displayImage;
  final List<TileModel> tiles;

  @override
  Widget build(BuildContext context) {
    var ingredientsWidgets = [
      for (var i in tiles)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (displayImage)
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                    maxWidth: 44,
                    maxHeight: 44,
                  ),
                  child: Image.asset(i.leading, fit: BoxFit.cover),
                ),
              if (displayImage) SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(i.title, style: bodyText1(context)),
                  Text(i.subtitle ?? "", style: bodyText2(context)),
                ],
              )
            ],
          ),
        )
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null) Text("$title", style: headline6(context)),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          direction: direction,
          children: ingredientsWidgets,
        )
      ],
    );
  }
}
