import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happy_at_work/api/send_sentiment_mood.dart';
import 'package:happy_at_work/api/sentiment_mood.dart';
import 'package:happy_at_work/models/mood.dart';
import 'package:happy_at_work/models/sentiment.dart';
import 'package:happy_at_work/providers/user_provider.dart';
import 'package:happy_at_work/screens/shared.dart';
import 'package:happy_at_work/screens/main_scaffold.dart';
import 'package:happy_at_work/screens/profile.dart';
import 'package:happy_at_work/widgets/error_body.dart';
import 'package:happy_at_work/widgets/first_choice_body.dart';
import 'package:happy_at_work/widgets/view_sentiment_insert_mood_body.dart';
import 'package:happy_at_work/widgets/loading_body.dart';

class SentimentScreen extends ConsumerStatefulWidget {
  const SentimentScreen({
    super.key,
  });

  @override
  ConsumerState<SentimentScreen> createState() => _SentimentScreenState();
}

class _SentimentScreenState extends ConsumerState<SentimentScreen> {
  SentimentState sentimentState = SentimentState.loading;
  Sentiment? sentiment;
  String? errorMessage;
  Mood? mood;

  void _updateSentResultMood(SendResult result) {
    _updateSentResult(result);
  }

  void _updateSentResult(SendResult result) {
    if (result.status == Status.ko) {
      setState(() {
        sentimentState = SentimentState.error;
        errorMessage = result.message;
      });
    } else {
      _getSentiment();
    }
  }

  void _navigateTo(MainScreenScaffoldNavigationType type, BuildContext ctx) {
    if (type == MainScreenScaffoldNavigationType.profile) {
      Navigator.of(ctx).push(MaterialPageRoute(
        builder: (ctx) => ProfileScreen(sentimentState: sentimentState),
      ));
    }
  }

  void _getSentiment() async {
    final user = ref.watch(userProvider);
    sentimentState = SentimentState.loading;
    final sentimentResult = await getSentimentMoodToday(user);
    if (sentimentResult.isError()) {
      setState(() {
        errorMessage = sentimentResult.errorMessage;
        sentimentState = SentimentState.error;
      });
    } else if (sentimentResult.isSentimentSelected()) {
      if (sentimentResult.isMoodSelected()) {
        setState(() {
          mood = sentimentResult.mood;
        });
      }
      setState(() {
        sentiment = sentimentResult.sentiment;
        sentimentState = SentimentState.selected;
      });
    } else if (!sentimentResult.isError() &&
        !sentimentResult.isSentimentSelected()) {
      setState(() {
        sentiment = null;
        sentimentState = SentimentState.notSelected;
      });
    }
  }

  /*@override
  void initState() {
    super.initState();
    _getSentiment();
  }*/

  @override
  void didChangeDependencies() {
    _getSentiment();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    switch (sentimentState) {
      case SentimentState.loading:
        body = const LoadingBody();
        break;
      case SentimentState.notSelected:
        body = FirstChoiceBody(onSendResult: _updateSentResult);
        break;
      case SentimentState.selected:
        body = SingleChildScrollView(
          child: ViewSentimentInsertMoodBody(
            sentiment: sentiment!,
            onModResultSentiment: _updateSentResult,
            onModResultMood: _updateSentResultMood,
            mood: mood,
          ),
        );
        break;
      case SentimentState.error:
        body = ErrorBody(message: errorMessage!);
        break;
    }

    return MainScreenScaffold(
      body: body,
      navigationType: MainScreenScaffoldNavigationType.sentiment,
      onNavigationTypeSelected: (MainScreenScaffoldNavigationType type) {
        _navigateTo(type, context);
      },
    );
  }
}
