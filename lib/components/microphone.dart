import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:gred_mobile/theme/colors.dart';

class Microphone extends StatelessWidget {
  const Microphone({
    Key key,
    bool isListening = false,
    int level = 30,
    void Function() onTap,
  })  : _isListening = isListening,
        _level = level,
        _fun = onTap,
        super(key: key);

  final bool _isListening;
  final int _level;
  final void Function() _fun;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _fun,
      child: AvatarGlow(
        glowColor: kColorWhite,
        endRadius: _level * 1.5,
        duration: Duration(milliseconds: 2000),
        repeat: _isListening,
        showTwoGlows: _isListening,
        repeatPauseDuration: Duration(milliseconds: 100),
        child: Material(
          elevation: 8.0,
          shape: CircleBorder(),
          child: CircleAvatar(
            backgroundColor: _isListening ? kColorAccent : kColorPrimary,
            child: Icon(
              _isListening ? Icons.mic : Icons.mic_none,
              size: 40,
              color: kColorWhite,
            ),
            radius: 25,
          ),
        ),
      ),
    );
  }
}
