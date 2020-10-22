import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gred_mobile/core/preference_access.dart';
import 'package:gred_mobile/theme/colors.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: SizedBox(height: 0)),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: kColorPrimary,
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                "Comment vous considerez-vous en cuisine ?",
                style: TextStyle(color: kColorWhite, fontSize: 25),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  chooseExpert();
                  Navigator.pushReplacementNamed(context, '/recipes');
                },
                color: kColorAccent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Je sais cuisiner",
                    style: TextStyle(color: kColorSecondary, fontSize: 25),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: OutlineButton(
                onPressed: () {
                  chooseNovice();
                  Navigator.pushReplacementNamed(context, '/recipes');
                },
                highlightedBorderColor: kColorSecondary,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Je sais faire à manger",
                    style: TextStyle(color: kColorSecondary, fontSize: 25),
                  ),
                ),
              ),
            ),
          ),
          Expanded(child: SizedBox(height: 0)),
        ],
      ),
    ));
  }
}
