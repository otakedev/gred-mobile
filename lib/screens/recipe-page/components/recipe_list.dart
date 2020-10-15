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
      this.direction = Axis.vertical,
      this.maxItems})
      : super(key: key);

  final String title;
  final Axis direction;
  final bool displayImage;
  final List<TileModel> tiles;
  final int maxItems;

  @override
  Widget build(BuildContext context) {
    List<TileModel> copy = new List();
    copy.addAll(tiles);
    if (tiles.isNotEmpty && maxItems != null) {
      if (tiles.length > maxItems) {
        copy.removeRange(maxItems, copy.length);
      }
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: kColorWhite,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: GredListTile(
          title: title,
          tiles: copy,
          displayImage: displayImage,
          maxItems: maxItems,
          trueLength: tiles.length,
          direction: direction),
    );
  }
}

class GredListTile extends StatelessWidget {
  const GredListTile(
      {Key key,
      this.title,
      @required this.tiles,
      this.direction,
      this.displayImage,
      this.maxItems,
      this.trueLength})
      : super(key: key);

  final String title;
  final Axis direction;
  final bool displayImage;
  final int maxItems;
  final int trueLength;
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

    if (maxItems != null) {
      if (maxItems < trueLength) {
        ingredientsWidgets.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "...",
            style: headline6(context),
          ),
        ));
      }
    }

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
