import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happy_at_work/api/microsoft_auth.dart';
import 'package:happy_at_work/api/send_sentiment_mood.dart';
import 'package:happy_at_work/providers/user_provider.dart';
import 'package:happy_at_work/screens/retry.dart';
import 'package:happy_at_work/screens/sentiment.dart';
import 'package:happy_at_work/screens/shared.dart';
import 'package:happy_at_work/widgets/loading_body.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  var _isLoggedIn = AuthState.loading;
  String? errorMessage;

  void _getResult() async {
    _isLoggedIn = AuthState.loading;
    var result = await login();
    if (result.status == Status.ok) {
      ref
          .read(userProvider.notifier)
          .updateUser(result.email!, result.nameSurname!);
      setState(() {
        _isLoggedIn = AuthState.loggedIn;
      });
    } else {
      setState(() {
        errorMessage = result.message;
        _isLoggedIn = AuthState.error;
      });
    }
  }

  @override
  void initState() {
    _getResult();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: (_isLoggedIn == AuthState.loading)
          ? const Scaffold(
              body: LoadingBody(),
            )
          : (_isLoggedIn == AuthState.error)
              ? RetryScreen(
                  errorMessage: errorMessage!,
                  onRetry: _getResult,
                )
              : const SentimentScreen(),
    );
  }
}
