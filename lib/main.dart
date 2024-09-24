import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happy_at_work/api/microsoft_auth.dart';
import 'package:happy_at_work/api/sentiment_mood.dart';
import 'package:happy_at_work/notifications/notifications.dart';
import 'package:happy_at_work/providers/user_log_provider.dart';
import 'package:happy_at_work/notifications/scheduling.dart';
import 'package:happy_at_work/screens/retry.dart';
import 'package:happy_at_work/screens/sentiment.dart';
import 'package:happy_at_work/widgets/loading_body.dart';

class SentimentChecker {
  Future<bool> Function()? checkerSentimentAdded;
}

void main() {
  var sentimentChecker = SentimentChecker();
  var notifId = 0;

  runApp(ProviderScope(
      child: App(
    sentimentChecker: sentimentChecker,
  )));

  // iniializza notificatore
  initializeNotification().then((myNotificator) {
    startScheduler(() async {
      if (sentimentChecker.checkerSentimentAdded != null) {
        var sentimentAdded = await sentimentChecker.checkerSentimentAdded!();
        if (!sentimentAdded) {
          AndroidNotificationDetails androidNotificationDetails =
              const AndroidNotificationDetails(
            'ID',
            'channel',
            importance: Importance.max,
            priority: Priority.high,
          );
          NotificationDetails notificationDetails =
              NotificationDetails(android: androidNotificationDetails);
          await myNotificator.show(
            notifId,
            'Inserisci il tuo sentiment giornaliero',
            'Non hai ancora inserito il tuo sentiment giornaliero, è il momento di farlo!!',
            notificationDetails,
          );
        }
      }
    });
  });
  // inizializza scheduler
}

class App extends ConsumerStatefulWidget {
  const App({
    super.key,
    required this.sentimentChecker,
  });

  final SentimentChecker sentimentChecker;

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  void _login() {
    Future.delayed(const Duration(milliseconds: 100), () {
      ref.read(userProvider.notifier).login();
    });
  }

  @override
  Widget build(BuildContext context) {
    var userLog = ref.watch(userProvider);

    if (userLog.isLoggedIn()) {
      widget.sentimentChecker.checkerSentimentAdded = () async {
        final sentimentResult = await getSentimentMoodToday(userLog.getUser());
        return sentimentResult.isSentimentSelected();
      };
    }

    if (userLog.isNone()) {
      _login();
    }

    Widget homeWidget = const LoadingBody(); // caso loading e none
    if (userLog.isError()) {
      homeWidget = RetryScreen(
        errorMessage: userLog.getErrorMessage(),
        onRetry: _login,
      );
    }
    if (userLog.isLoggedIn()) {
      homeWidget = const SentimentScreen();
    }

    return MaterialApp(
      home: homeWidget,
      navigatorKey: navigatorKey,
    );
  }
}
