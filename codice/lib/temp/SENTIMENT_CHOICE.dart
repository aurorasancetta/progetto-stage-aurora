import 'package:flutter/material.dart';
import 'package:happy_at_work/models/sentiment.dart';

class SentimentChoice extends StatefulWidget {
  const SentimentChoice(this.setPressed, {super.key});

  final void Function(bool, int) setPressed;

  @override
  State<SentimentChoice> createState() => _SentimentChoiceState();
}

class _SentimentChoiceState extends State<SentimentChoice> {
  var _isPressed = false;
  var _whichPressed = 999;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Come va oggi?',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 50),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.surface,
            ),
            height: 300,
            width: 300,
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              padding: const EdgeInsets.all(15),
              children: [
                for (var value in Type.values)
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _isPressed = !_isPressed;
                            _whichPressed = value.index + 1;
                            widget.setPressed(_isPressed, _whichPressed);
                          });
                        },
                        icon: Image.asset(typeImage[value]!),
                      ),
                      Text(typeName[value]!),
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
