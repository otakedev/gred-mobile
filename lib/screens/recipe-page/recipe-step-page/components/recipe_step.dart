import 'package:flutter/material.dart';
import 'package:gred_mobile/components/draw/DownTriangleClipper.dart';
import 'package:gred_mobile/core/preference_access.dart';
import 'package:gred_mobile/core/text_style.dart';
import 'package:gred_mobile/models/recipe_step_model.dart';
import 'package:gred_mobile/providers/recipe_step_provider.dart';
import 'package:gred_mobile/theme/colors.dart';
import 'package:provider/provider.dart';

import 'help_dialog.dart';

class RecipeStep extends StatelessWidget {
  const RecipeStep(this.index, {Key key}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    var item = context.select<RecipeStepProvider, RecipeStepModel>(
      (provider) => provider.findByIndex(index),
    );

    bool isHelpAvailable = item.help != null;

    return Stack(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
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
                ),
                SizedBox(height: 10),
                Expanded(
                  flex: 5,
                  child: Container(
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
                          child: Text("${item.title ?? ''}",
                              style: headline6(context)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text('${item.description}'),
                        ),
                        Spacer(),
                        if (isHelpAvailable)
                          FutureBuilder(
                              future: checkUserSkill(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                if (snapshot.hasData) {
                                  return snapshot.data == "NOVICE"
                                      ? Container(
                                          padding: const EdgeInsets.all(16.0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(30.0),
                                                bottomRight:
                                                    Radius.circular(30.0)),
                                            color: kColorAccent,
                                          ),
                                          child: GestureDetector(
                                            onTap: () => {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) =>
                                                      HelpDialog(index)),
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  // Icons.play_circle_outline,
                                                  Icons.info_outline,
                                                  size: 40,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '${item.help.videoTitle}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      : SizedBox.shrink();
                                } else
                                  return SizedBox.shrink();
                              }),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 10,
                  child: isHelpAvailable
                      ? Align(
                          alignment: Alignment(0.27, 0),
                          child: ClipPath(
                              clipper: DownTriangleClipper(),
                              child: Container(width: 10, color: kColorAccent)),
                        )
                      : null,
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: kColorSecondary,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(30)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("$index",
                style: TextStyle(fontSize: 40, color: kColorPrimary)),
          ),
        ),
      ],
    );
  }
}
