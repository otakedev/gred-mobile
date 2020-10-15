import 'package:flutter/material.dart';
import 'package:gred_mobile/providers/speech_provider.dart';
import 'package:gred_mobile/screens/vocal-dialog-page/components/vocal_dialog.dart';
import 'package:provider/provider.dart';

class VocalPage extends StatelessWidget {
  const VocalPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VocalDialog(
        onNo: () => {
          context.read<SpeechProvider>().stopListening(),
          Navigator.pushReplacementNamed(context, '/steps'),
        },
        onYes: () => {
          context.read<SpeechProvider>().startListening(),
          Navigator.pushReplacementNamed(context, '/steps'),
        },
      ),
    );
  }
}
