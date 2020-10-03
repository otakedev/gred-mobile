import 'package:flutter/material.dart';
import 'package:gred_mobile/providers/Counter.dart';
import 'package:gred_mobile/screens/counter-page/CounterPage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Counter(),
      child: CounterPage(),
    );
  }
}
