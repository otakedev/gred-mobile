import 'package:flutter/material.dart';
import 'package:gred_mobile/core/text_style.dart';
import 'package:gred_mobile/screens/recipe-page/components/cook_level.dart';
import 'package:gred_mobile/theme/colors.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard(
      {Key key,
      @required this.imageUrl,
      @required this.avatarUrl,
      @required this.author,
      @required this.difficulty,
      @required this.title})
      : super(key: key);

  final String imageUrl;
  final String avatarUrl;
  final String author;
  final int difficulty;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Stack(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Image(
                                height: 220,
                                width: double.infinity,
                                image: AssetImage(imageUrl),
                                fit: BoxFit.cover))),
                    Positioned(
                        bottom: -25,
                        left: 40,
                        child: CircleAvatar(
                            backgroundImage: AssetImage(avatarUrl),
                            radius: 40)),
                    Positioned(
                      bottom: -15,
                      left: 135,
                      child: Text(
                        author,
                        style: TextStyle(color: kColorPrimary),
                      ),
                    )
                  ],
                  overflow: Overflow.visible,
                ),
              ),
              Center(
                child:
                    SizedBox(width: 100, child: CookLevel(level: difficulty)),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  title,
                  style: headline6(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
