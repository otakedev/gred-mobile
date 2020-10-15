import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

enum Command { NEXT, PREVIOUS, NONE }

class SpeechProvider extends ChangeNotifier {
  static const platform = const MethodChannel('gred_mobile/audio_manager');

  final SpeechToText speech = SpeechToText();

  double _level = 0.0;
  var _localeId = "en_US"; //fr_CA or en_US
  bool _hasSpeech = false;
  bool _isActive = false;
  Command _command = Command.NONE;

  get level => _level;
  get hasSpeech => _hasSpeech;
  get isActive => _isActive;
  get command => _command;

  void initSpeech() async {
    bool hasSpeech = await speech.initialize(
      onError: errorListener,
      onStatus: statusListener,
    );

    if (hasSpeech) {
      var systemLocale = await speech.systemLocale();
      _localeId = systemLocale.localeId;
    }

    _hasSpeech = hasSpeech;
  }

  Future<void> muteSound() async {
    await platform.invokeMethod('setStreamMusicMute');
  }

  Future<void> unmuteSound() async {
    await platform.invokeMethod('setStreamMusicUnmute');
  }

  void startListening() async {
    if (!_hasSpeech) {
      initSpeech();
    }
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(minutes: 10),
        localeId: _localeId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        partialResults: true,
        listenMode: ListenMode.confirmation);
    await Future.delayed(Duration(milliseconds: 50));
    await muteSound();
    _isActive = true;
    notifyListeners();
  }

  void restartListening() async {
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(minutes: 10),
        localeId: _localeId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        partialResults: true,
        listenMode: ListenMode.confirmation);
  }

  void stopListening() async {
    await unmuteSound();
    speech.stop();
    _isActive = false;
    notifyListeners();
  }

  void soundLevelListener(double level) {
    this._level = level;
  }

  void errorListener(SpeechRecognitionError error) async {
    await Future.delayed(Duration(milliseconds: 50));
    if (!_hasSpeech) {
      initSpeech();
    }
    await Future.delayed(Duration(milliseconds: 50));
    restartListening();
  }

  void statusListener(String status) async {}

  void resultListener(SpeechRecognitionResult result) async {
    this._command = Command.NONE;
    if (!result.finalResult) {
      return;
    }
    if (result.recognizedWords.toLowerCase().contains('next')) {
      this._command = Command.NEXT;
      notifyListeners();
    } else if (result.recognizedWords.toLowerCase().contains('previous')) {
      this._command = Command.PREVIOUS;
      notifyListeners();
    } else {
      this._command = Command.NONE;
    }
    await Future.delayed(Duration(milliseconds: 50));
    this._command = Command.NONE;
    restartListening();
  }

  void cancelListening() {
    speech.cancel();
    restartListening();
  }

  void switchListeningMode() {
    if (_isActive) {
      stopListening();
    } else {
      startListening();
    }
  }
}
