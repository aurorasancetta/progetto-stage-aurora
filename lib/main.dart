import 'package:flutter/material.dart';

import 'package:happy_at_work/screens/login.dart';
import 'package:happy_at_work/screens/sentiment.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SentimentScreen(),
      navigatorKey: navigatorKey,
    );
  }
}
