import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_at_work/api/send_sentiment_mood.dart';
import 'package:happy_at_work/models/sentiment.dart';
import 'package:happy_at_work/screens/second_choice.dart';

class FirstChoiceBody extends StatefulWidget {
  const FirstChoiceBody({
    super.key,
    required this.onSendResult,
  });

  final void Function(SendResult) onSendResult;

  @override
  State<FirstChoiceBody> createState() => _FirstChoiceBodyState();
}

class _FirstChoiceBodyState extends State<FirstChoiceBody> {
  Sentiment? sentiment;
  var _whichPressed = 999;

  void _sendSent() async {
    final data = await Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => SecondChoiceScreen(_whichPressed, sentiment),
    ));
    widget.onSendResult(data);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Come va oggi?',
            style: GoogleFonts.ptSerif(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
          const SizedBox(height: 48),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.surface,
            ),
            height: 304,
            width: 304,
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              padding: const EdgeInsets.all(16),
              children: [
                for (var value in SType.values)
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _whichPressed = value.index + 1;
                          });
                          _sendSent();
                        },
                        icon: Image.asset(typeImage[value]!),
                      ),
                      Text(
                        typeName[value]!,
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
