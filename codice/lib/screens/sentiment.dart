import 'package:flutter/material.dart';
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
  var _isPressed = false;
  var _whichPressed = 999;

  void setIsPressed(isPressed, whichPressed) {
    setState(() {
      _isPressed = isPressed;
      _whichPressed = whichPressed;
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
        !_isPressed
            ? SentimentChoice(setIsPressed)
            : SentimentReason(_whichPressed),
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
