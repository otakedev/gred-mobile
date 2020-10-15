import 'package:flutter/material.dart';
import 'package:gred_mobile/theme/colors.dart';

class VocalDialog extends StatelessWidget {
  const VocalDialog({
    Key key,
    this.onYes,
    this.onNo,
  }) : super(key: key);

  final void Function() onYes;
  final void Function() onNo;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                "Voulez-vous activer le mode vocal pour cette recette",
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
                onPressed: onYes,
                color: kColorAccent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Oui",
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
                onPressed: onNo,
                highlightedBorderColor: kColorSecondary,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Non",
                    style: TextStyle(color: kColorSecondary, fontSize: 25),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: kColorSecondary,
                      size: 30,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Wrap(
                        direction: Axis.horizontal,
                        children: [
                          Text(
                            "Certaines étapes de la recette peuvent être salissantes",
                            style: TextStyle(color: kColorSecondary),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
