import 'package:flutter/material.dart';
import 'package:happy_at_work/models/sentiment.dart';
import 'package:happy_at_work/screens/choice.dart';

class Start extends StatefulWidget {
  const Start(this.setPressedI, this.setSentiment, {super.key});

  final void Function(bool) setPressedI;
  final void Function(Sentiment) setSentiment;

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  var _whichPressed = 999;
  var _isPressedI = false;
  Sentiment? _newSent;

  void _sendSent() async {
    final data = await Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => ChoiceScreen(_whichPressed, _newSent),
    ));
    var pressed = data['isPressedI'];
    var newSent = data['newSent'];
    setState(() {
      _isPressedI = pressed;
      _newSent = newSent;
      widget.setPressedI(_isPressedI);
      widget.setSentiment(_newSent!);
    });
  }

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
                            _whichPressed = value.index + 1;
                          });
                          _sendSent();
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
