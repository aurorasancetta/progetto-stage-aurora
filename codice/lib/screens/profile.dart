import 'package:flutter/material.dart';
import 'package:happy_at_work/screens/shared.dart';
import 'package:happy_at_work/screens/main_scaffold.dart';
import 'package:happy_at_work/screens/sentiment.dart';
import 'package:happy_at_work/widgets/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.sentimentState,
  });

  final SentimentState sentimentState;

  void _navigateTo(MainScreenScaffoldNavigationType type, BuildContext ctx) {
    if (type == MainScreenScaffoldNavigationType.sentiment) {
      Navigator.of(ctx).push(MaterialPageRoute(
        builder: (ctx) => SentimentScreen(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenScaffold(
      body: ProfileBody(),
      navigationType: MainScreenScaffoldNavigationType.profile,
      onNavigationTypeSelected: (MainScreenScaffoldNavigationType type) {
        _navigateTo(type, context);
      },
    );
  }
}
