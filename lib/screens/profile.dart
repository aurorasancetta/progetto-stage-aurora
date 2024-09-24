import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happy_at_work/providers/user_log_provider.dart';
import 'package:happy_at_work/screens/shared.dart';
import 'package:happy_at_work/screens/main_scaffold.dart';
import 'package:happy_at_work/screens/sentiment.dart';
import 'package:happy_at_work/widgets/loading_body.dart';
import 'package:happy_at_work/widgets/profile_body.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({
    super.key,
  });

  void _navigateTo(MainScreenScaffoldNavigationType type, BuildContext ctx) {
    if (type == MainScreenScaffoldNavigationType.sentiment) {
      Navigator.of(ctx).push(MaterialPageRoute(
        builder: (ctx) => const SentimentScreen(),
      ));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userLog = ref.watch(userProvider);

    return MainScreenScaffold(
      body: !userLog.isLoggedIn() ? const LoadingBody() : const ProfileBody(),
      navigationType: MainScreenScaffoldNavigationType.profile,
      onNavigationTypeSelected: (MainScreenScaffoldNavigationType type) {
        _navigateTo(type, context);
      },
    );
  }
}
