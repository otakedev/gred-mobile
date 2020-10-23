import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gred_mobile/core/text_style.dart';
import 'package:gred_mobile/models/tiles_model.dart';
import 'package:gred_mobile/screens/recipe-page/recipe-step-page/components/step_tracking_dialog.dart';
import 'package:gred_mobile/theme/colors.dart';

class RecipeList extends StatelessWidget {
  const RecipeList({
    Key key,
    this.title,
    @required this.tiles,
    this.fullLenght = false,
    this.displayImage = true,
    this.direction = Axis.vertical,
    this.maxItems,
    this.index,
  }) : super(key: key);

  final String title;
  final Axis direction;
  final bool displayImage;
  final List<TileModel> tiles;
  final int maxItems;
  final int index;
  final bool fullLenght;

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
          fullLenght: fullLenght,
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
  const GredListTile({
    Key key,
    this.title,
    @required this.tiles,
    this.direction,
    this.displayImage,
    this.maxItems,
    this.index,
    this.trueLength,
    this.fullLenght,
  }) : super(key: key);

  final String title;
  final Axis direction;
  final bool displayImage;
  final int maxItems;
  final int index;
  final int trueLength;
  final List<TileModel> tiles;
  final bool fullLenght;

  @override
  Widget build(BuildContext context) {
    var ingredientsWidgets = ingredientsListWidgets(context);

    if (maxItems != null && maxItems < trueLength) {
      ingredientsWidgets.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: index != null
              ? CircleAvatar(
                  radius: 20,
                  backgroundColor: kColorSecondary,
                  child: IconButton(
                    icon: Icon(Icons.more_horiz, size: 20),
                    onPressed: () => {
                      showDialog(
                          context: context,
                          builder: (_) => StepTrackingDialog(index)),
                    },
                  ),
                )
              : Text(
                  "...",
                  style: headline6(context),
                ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
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

  List<Padding> ingredientsListWidgets(context) {
    double width = MediaQuery.of(context).size.width *
        MediaQuery.of(context).devicePixelRatio;
    double height = MediaQuery.of(context).size.height *
        MediaQuery.of(context).devicePixelRatio;
    return [
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
              Container(
                width: fullLenght
                    ? 200
                    : (width < 1500 || height < 1500)
                        ? 80
                        : 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      i.title,
                      style: bodyText1(context),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      i.subtitle ?? "",
                      style: bodyText2(context),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    ];
  }
}
