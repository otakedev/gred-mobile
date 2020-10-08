import 'package:flutter/material.dart';
import 'package:gred_mobile/core/text_style.dart';
import 'package:gred_mobile/models/tiles_model.dart';
import 'package:gred_mobile/theme/colors.dart';

class RecipeList extends StatelessWidget {
  const RecipeList({Key key, this.title, @required this.tiles})
      : super(key: key);

  final String title;
  final List<TileModel> tiles;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: kColorWhite,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${title ?? ''}", style: headline6(context)),
          for (var i in tiles)
            ListTile(
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 44,
                  maxHeight: 44,
                ),
                child: Image.asset(i.leading, fit: BoxFit.cover),
              ),
              title: Text(i.title),
              subtitle: Text(i.subtitle ?? ""),
            ),
        ],
      ),
    );
  }
}
