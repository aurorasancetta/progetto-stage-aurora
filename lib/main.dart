import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happy_at_work/api/microsoft_auth.dart';
import 'package:happy_at_work/api/send_sentiment_mood.dart';
import 'package:happy_at_work/api/sentiment_mood.dart';
import 'package:happy_at_work/notifications.dart';
import 'package:happy_at_work/providers/user_provider.dart';
import 'package:happy_at_work/scheduling.dart';
import 'package:happy_at_work/screens/retry.dart';
import 'package:happy_at_work/screens/sentiment.dart';
import 'package:happy_at_work/screens/shared.dart';
import 'package:happy_at_work/widgets/loading_body.dart';

class SentimentChecker {
  bool Function()? check;

  /*static SentimentChecker check(final bool Function() callback) {
    var checker = SentimentChecker();
    checker.callback = callback;
    return checker;
  }*/
}

void main() {
  var sentimentChecker = SentimentChecker();

  runApp(ProviderScope(
      child: App(
    checker: sentimentChecker,
  )));

  // iniializza notificatore
  var myNotificator = initializeNotification();
  // inizializza scheduler
  startScheduler(() {
    if (!sentimentChecker.check!()) {
      myNotificator.show(); // sistema qua!!!!!!
    }
  });
}

class App extends ConsumerStatefulWidget {
  const App({
    super.key,
    required this.checker,
  });

  final SentimentChecker checker;

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  void _getResult() {
    ref.read(userProvider.notifier).login();
  }

  @override
  void initState() {
    _getResult();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userLog = ref.watch(userProvider);

    widget.checker.check = () async {
      final sentimentResult = await getSentimentMoodToday(userLog.getUser());
      return sentimentResult.isSentimentSelected();
    } as bool Function()?;

    return MaterialApp(
      home: (userLog.isLogging())
          ? const Scaffold(
              body: LoadingBody(),
            )
          : (userLog.isError())
              ? RetryScreen(
                  errorMessage: userLog.getErrorMessage(),
                  onRetry: _getResult,
                )
              : const SentimentScreen(),
      navigatorKey: navigatorKey,
    );
  }
}
