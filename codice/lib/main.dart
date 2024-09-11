import 'package:flutter/material.dart';
import 'package:happy_at_work/screens/login.dart';
import 'package:happy_at_work/screens/sentiment.dart';

void main() {
  bool isLoggedIn = false;

  runApp(
    MaterialApp(
      home: isLoggedIn ? SentimentScreen() : LoginScreen(),
      navigatorKey: navigatorKey,
    ),
  );
}
