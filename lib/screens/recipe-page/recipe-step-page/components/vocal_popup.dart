import 'package:flutter/material.dart';
import 'package:gred_mobile/theme/colors.dart';

class VocalPopup extends StatelessWidget {
  const VocalPopup({
    Key key,
    this.text,
    this.onYes,
    this.onNo,
  }) : super(key: key);

  final void Function() onYes;
  final void Function() onNo;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      backgroundColor: kColorBackground,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              text,
              style: TextStyle(color: kColorSecondary, fontSize: 25),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: RaisedButton(
              onPressed: () {
                onYes();
                Navigator.pop(context, false);
              },
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
              onPressed: () {
                onNo();
                Navigator.pop(context, false);
              },
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
      ],
    );
  }
}
