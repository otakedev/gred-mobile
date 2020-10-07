import 'package:flutter/material.dart';
import 'package:gred_mobile/core/text_style.dart';
import 'package:gred_mobile/theme/colors.dart';

class RecipeList extends StatelessWidget {
  const RecipeList({
    Key key,
    this.title,
    @required this.elems,
  }) : super(key: key);

  final String title;
  final List<String> elems;

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
          for (var i in elems) Text('- $i', style: TextStyle(height: 1.5)),
        ],
      ),
    );
  }
}
