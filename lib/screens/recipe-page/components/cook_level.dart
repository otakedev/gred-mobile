import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gred_mobile/theme/colors.dart';

class CookLevel extends StatelessWidget {
  const CookLevel({
    Key key,
    int level = 1,
  })  : _level = level,
        super(key: key);

  final int _level;
  final String levelOn = "assets/images/chef-2.svg";
  final String levelOff = "assets/images/chef-1.svg";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: kColorWhite,
        borderRadius: new BorderRadius.all(
          const Radius.circular(30.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SvgPicture.asset(levelOn),
            SvgPicture.asset(_level > 1 ? levelOn : levelOff),
            SvgPicture.asset(_level > 2 ? levelOn : levelOff),
          ],
        ),
      ),
    );
  }
}
