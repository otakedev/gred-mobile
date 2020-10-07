import 'package:flutter/material.dart';
import 'package:gred_mobile/core/text_style.dart';
import 'package:gred_mobile/models/recipe_step_model.dart';
import 'package:gred_mobile/providers/recipe_step_provider.dart';
import 'package:gred_mobile/theme/colors.dart';
import 'package:provider/provider.dart';

class RecipeStep extends StatelessWidget {
  const RecipeStep(this.index, {Key key}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    var item = context.select<RecipeStepProvider, RecipeStepModel>(
      (provider) => provider.findByIndex(index),
    );

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                image: DecorationImage(
                  image: AssetImage(item.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: kColorWhite,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        Text("${item.title ?? ''}", style: headline6(context)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('${item.description}'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
