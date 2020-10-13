import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gred_mobile/components/draw/DownTriangleClipper.dart';
import 'package:gred_mobile/core/preference_access.dart';
import 'package:gred_mobile/core/text_style.dart';
import 'package:gred_mobile/models/recipe_step_model.dart';
import 'package:gred_mobile/providers/recipe_step_provider.dart';
import 'package:gred_mobile/screens/recipe-page/components/recipe_list.dart';
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: OrientationBuilder(builder: (context, orientation) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: orientation == Orientation.portrait
                      ? Column(
                          children: [
                            Expanded(
                              flex: 3,
                              child: GredImage(item: item),
                            ),
                            SizedBox(height: 10, width: 10),
                            Expanded(
                              flex: 5,
                              child: GredDescription(
                                item: item,
                                isAccent: isHelpAvailable,
                                index: index,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: GredImage(item: item),
                            ),
                            SizedBox(height: 10, width: 10),
                            Expanded(
                              flex: 5,
                              child: GredDescription(
                                item: item,
                                isAccent: isHelpAvailable,
                                index: index,
                              ),
                            ),
                          ],
                        ),
                ),
                Container(
                  height: 10,
                  child: FutureBuilder(
                    future: checkUserSkill(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return snapshot.hasData &&
                              snapshot.data == "NOVICE" &&
                              isHelpAvailable
                          ? GredArrow(orientation: orientation)
                          : SizedBox();
                    },
                  ),
                ),
                SizedBox(height: 50),
              ],
            );
          }),
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

class GredArrow extends StatelessWidget {
  final Orientation orientation;

  const GredArrow({Key key, this.orientation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          Alignment(orientation == Orientation.portrait ? 0.265 : 0.30, 0),
      child: ClipPath(
        clipper: DownTriangleClipper(),
        child: Container(width: 10, color: kColorAccent),
      ),
    );
  }
}

class GredDescription extends StatelessWidget {
  const GredDescription({
    Key key,
    @required this.item,
    @required this.isAccent,
    @required this.index,
  }) : super(key: key);

  final RecipeStepModel item;
  final bool isAccent;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: kColorWhite,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('${item.description}', style: bodyText1(context)),
          ),
          RecipeList(
            tiles: item.ingredients,
            displayImage: false,
            direction: Axis.horizontal,
          ),
          Spacer(),
          if (isAccent)
            FutureBuilder(
                future: checkUserSkill(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data == "NOVICE"
                        ? Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30.0),
                                  bottomRight: Radius.circular(30.0)),
                              color: kColorAccent,
                            ),
                            child: GestureDetector(
                              onTap: () => {
                                showDialog(
                                    context: context,
                                    builder: (_) => HelpDialog(index)),
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    size: 40,
                                    color: kColorSecondary,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${item.help.videoTitle}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: bodyText2(context),
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
    );
  }
}

class GredImage extends StatelessWidget {
  const GredImage({
    Key key,
    @required this.item,
  }) : super(key: key);

  final RecipeStepModel item;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: new BorderRadius.circular(30.0),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(item.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
            child: ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.black.withOpacity(0.0)],
                    stops: [0.4, 0.90]).createShader(rect);
              },
              blendMode: BlendMode.dstOut,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(item.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          if (item.title != null)
            Padding(
              padding: const EdgeInsets.only(left: 60),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${item.title ?? ''}",
                  style: TextStyle(fontSize: 30, color: kColorWhite),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
