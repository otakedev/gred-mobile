import 'package:flutter/material.dart';
import 'package:gred_mobile/screens/HomePage.dart';
import 'package:gred_mobile/theme/style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gred App',
      theme: appTheme(),
      home: HomePage(),
    );
  }
}
