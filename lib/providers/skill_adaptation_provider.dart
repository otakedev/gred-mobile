import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gred_mobile/core/preference_access.dart';

class SkillAdaptationProvider extends ChangeNotifier {
  int maxBeforeSwitchLevel = 2;
  int countHelpAsk = 0;
  bool changed = false;
  bool askAgain = true;

  void detectHelpAsked() {
    countHelpAsk++;
    if (countHelpAsk > maxBeforeSwitchLevel && askAgain) {
      chooseNovice();
      changed = true;
    }
    notifyListeners();
  }

  void resetHelpAsk() {
    countHelpAsk = 0;
    changed = false;
    askAgain = true;
    // chooseExpert();
    notifyListeners();
  }

  void doNotAskAgain() {
    askAgain = false;
  }

  // bool get didChanged => changed;
}
