import 'dart:async';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gred_mobile/components/draw/DownTriangleClipper.dart';
import 'package:gred_mobile/core/global_key.dart';
import 'package:gred_mobile/core/preference_access.dart';
import 'package:gred_mobile/core/text_style.dart';
import 'package:gred_mobile/models/recipe_step_model.dart';
import 'package:gred_mobile/providers/recipe_step_provider.dart';
import 'package:gred_mobile/providers/speech_provider.dart';
import 'package:gred_mobile/screens/recipe-page/components/recipe_list.dart';
import 'package:gred_mobile/screens/recipe-page/recipe-step-page/components/vocal_popup.dart';
import 'package:gred_mobile/theme/colors.dart';
import 'package:provider/provider.dart';

import 'help_dialog.dart';

class RecipeStep extends StatefulWidget {
  const RecipeStep(this.index, {Key key}) : super(key: key);

  final int index;

  @override
  _RecipeStepState createState() => _RecipeStepState();
}

class _RecipeStepState extends State<RecipeStep> {
  Timer _timer;

  @override
  void dispose() {
    if (_timer != null) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var item = context.select<RecipeStepProvider, RecipeStepModel>(
      (provider) => provider.findByIndex(widget.index),
    );

    var isVocalEnabled = context.select<RecipeStepProvider, bool>(
      (provider) => provider.isVocalEnabled,
    );

    var isDisabled = false;

    context.select<SpeechProvider, bool>((provider) {
      if (!provider.isActive && isVocalEnabled && !isDisabled) {
        isDisabled = true;
        if (_timer != null) _timer.cancel();
        _timer = Timer(
          // Duration(seconds: item.timeEstimated),
          // mocked
          Duration(seconds: 5),
          () => openAskVocalDialog(context),
        );
      }
      return provider.isActive;
    });

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
                                index: widget.index,
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
                                index: widget.index,
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
            child: Text("${widget.index}",
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
  // 1080 x 1920 pixels -> meizu
  // 1080 x 2340 pixels -> oneplus 7

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
    double height = MediaQuery.of(context).size.height *
        MediaQuery.of(context).devicePixelRatio;
    double width = MediaQuery.of(context).size.width *
        MediaQuery.of(context).devicePixelRatio;

    Orientation deviceOrientation = MediaQuery.of(context).orientation;

    bool isWideScreenPortrait = height >= 2000;
    bool isWideScreenLandscape = width >= 2000;

    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: kColorWhite,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: isWideScreenPortrait || isWideScreenLandscape
                          ? const EdgeInsets.fromLTRB(25, 15, 25, 0)
                          : const EdgeInsets.all(16.0),
                      child: AutoSizeText(
                        '${item.description}',
                        style: headline6(context),
                        maxLines: deviceOrientation == Orientation.portrait
                            ? (height <= 900
                                ? 4
                                : isWideScreenPortrait
                                    ? 10
                                    : (item.ingredients.length < 3 ? 8 : 4))
                            : (width <= 900
                                ? 4
                                : (isWideScreenLandscape
                                    ? 10
                                    : (item.ingredients.length < 3 ? 6 : 3))),
                      ),
                    ),
                    width > 800
                        ? FutureBuilder(
                            future: checkUserSkill(),
                            builder: (context, snapshot) {
                              return RecipeList(
                                  index: index,
                                  maxItems: (deviceOrientation ==
                                          Orientation.portrait
                                      ? (isWideScreenPortrait
                                          ? 10
                                          : (snapshot.data == "NOVICE" ? 4 : 8))
                                      : (isWideScreenLandscape
                                          ? 10
                                          : (snapshot.data == "NOVICE"
                                              ? 2
                                              : 4))),
                                  tiles: item.ingredients,
                                  displayImage:
                                      (deviceOrientation == Orientation.portrait
                                          ? (isWideScreenPortrait
                                              ? true
                                              : (item.help == null))
                                          : (isWideScreenLandscape
                                              ? false
                                              : (item.help == null))),
                                  direction: Axis.horizontal);
                            },
                          )
                        : SizedBox(),
                  ],
                ),
              ),
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
                                        Icons.play_circle_outline,
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
                                          style: bodyText1(context),
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
      },
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

void openAskVocalDialog(BuildContext context) {
  showDialog(
    context: scaffoldVocalDialogKey.currentContext,
    builder: (_) => VocalPopup(
      text:
          "Il semblerait que vous êtes inactif, voulez-vous activer le mode vocal ?",
      onNo: () => {
        context.read<RecipeStepProvider>().isVocalEnabled = false,
        context.read<SpeechProvider>().stopListening(),
      },
      onYes: () => {
        context.read<RecipeStepProvider>().isVocalEnabled = false,
        context.read<SpeechProvider>().startListening(),
      },
    ),
  );
}
