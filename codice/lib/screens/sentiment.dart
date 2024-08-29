import 'package:flutter/material.dart';
import 'package:happy_at_work/models/sentiment.dart';
import 'package:happy_at_work/widgets/review.dart';
import 'package:happy_at_work/widgets/sentiment_choice.dart';
import 'package:happy_at_work/widgets/sentiment_reason.dart';

class SentimentScreen extends StatefulWidget {
  const SentimentScreen({super.key});

  @override
  State<SentimentScreen> createState() {
    return _SentimentScreenState();
  }
}

class _SentimentScreenState extends State<SentimentScreen> {
  var _selectedpageIndex = 0;
  var _isPressedC = false;
  var _whichPressedC = 999;
  var _isPressedI = false;
  Sentiment _newSent = Sentiment(type: Type.entusiasta);

  void setIsPressedC(isPressed, whichPressed) {
    setState(() {
      _isPressedC = isPressed;
      _whichPressedC = whichPressed;
    });
  }

  void setIsPressedI(isPressed) {
    setState(() {
      _isPressedI = isPressed;
    });
  }

  void setSentiment(sent) {
    setState(() {
      _newSent = sent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: <Widget>[
        if (!_isPressedC) SentimentChoice(setIsPressedC),
        if (!_isPressedI)
          SentimentReason(_whichPressedC, setIsPressedI, setSentiment)
        else
          Review(_newSent),
        // profile screen
        const SizedBox.expand(
          child: Center(
            child: Text('profile screen'),
          ),
        ),
      ][_selectedpageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _selectedpageIndex = index;
          });
        },
        selectedIndex: _selectedpageIndex,
        destinations: const <Widget>[
          NavigationDestination(
              icon: Icon(Icons.emoji_emotions), label: 'Sentiment'),
          NavigationDestination(
              icon: Icon(Icons.account_circle), label: 'Profilo'),
        ],
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
