import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gred_mobile/core/text_style.dart';
import 'package:gred_mobile/models/recipe_step_model.dart';
import 'package:gred_mobile/models/tiles_model.dart';
import 'package:gred_mobile/providers/recipe_provider.dart';
import 'package:gred_mobile/providers/recipe_step_provider.dart';
import 'package:gred_mobile/screens/recipe-page/recipe-step-page/components/step_tracking_dialog.dart';
import 'package:gred_mobile/theme/colors.dart';
import 'package:provider/provider.dart';

class RecipeList extends StatelessWidget {
  const RecipeList(
      {Key key,
      this.title,
      @required this.tiles,
      this.displayImage = true,
      this.direction = Axis.vertical,
      this.maxItems,
      int this.index})
      : super(key: key);

  final String title;
  final Axis direction;
  final bool displayImage;
  final List<TileModel> tiles;
  final int maxItems;
  final int index;

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
          index: index,
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
      this.index,
      this.trueLength})
      : super(key: key);

  final String title;
  final Axis direction;
  final bool displayImage;
  final int maxItems;
  final int index;
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
          child: index != null
              ? RaisedButton(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "...",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  color: kColorSecondary,
                  onPressed: () => {
                        showDialog(
                            context: context,
                            builder: (_) => StepTrackingDialog(index)),
                      },
                  shape: CircleBorder())
              : Text(
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
