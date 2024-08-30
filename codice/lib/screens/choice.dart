import 'package:flutter/material.dart';
import 'package:happy_at_work/models/sentiment.dart';

class ChoiceScreen extends StatefulWidget {
  const ChoiceScreen(this.pressedC, this.sentiment, {super.key});

  final int pressedC;
  final Sentiment? sentiment;

  @override
  State<ChoiceScreen> createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen> {
  var _indexC = 999;
  var _indexR = 999;
  var _isPressedI = false;
  var _sentC = ' ';
  var _why = ' ';
  var _enteredComment = '';
  final _date = DateTime.now();
  Sentiment? newSent;

  Sentiment _saveItem() {
    newSent = Sentiment(
      type: Type.values[_indexC - 1],
      reason: Reason.values[_indexR - 1],
      comment: _enteredComment,
      date: _date,
    );
    return newSent!;
  }

  @override
  void initState() {
    _indexC = widget.pressedC;
    if (widget.sentiment != null) {
      if (widget.sentiment!.reason != null) {
        _indexR = widget.sentiment!.reason!.index + 1;
      }
      if (widget.sentiment!.comment != null) {
        _enteredComment = widget.sentiment!.comment!;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_indexC == 1) {
      _sentC = typeName[Type.entusiasta]!;
      _why = 'Cosa ha influito positivamente?';
    } else if (_indexC == 2) {
      _sentC = typeName[Type.soddisfatto]!;
      _why = 'Cosa ha influito positivamente?';
    } else if (_indexC == 3) {
      _sentC = typeName[Type.insoddisfatto]!;
      _why = 'Cosa ha influito negativamente?';
    } else if (_indexC == 4) {
      _sentC = typeName[Type.frustrato]!;
      _why = 'Cosa ha influito negativmente?';
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Come va oggi?',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            // opzioni di sentiment
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var value in Type.values)
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _indexC = (value.index + 1);
                      });
                    },
                    icon: _indexC == value.index + 1
                        ? Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 5,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            child: Image.asset(typeImage[value]!),
                          )
                        : SizedBox(
                            height: 70,
                            width: 70,
                            child: Image.asset(typeImage[value]!)),
                  ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              height: 30,
              width: 110,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Theme.of(context).colorScheme.secondaryContainer),
                  color: Theme.of(context).colorScheme.onPrimary),
              child: Text(_sentC),
            ),
            const SizedBox(height: 20),
            // motivazioni sentiment
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 10),
                Text(
                  _why,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer),
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                scrollDirection: Axis.horizontal,
                children: [
                  for (var value in Reason.values)
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _indexR = (value.index + 1);
                        });
                      },
                      label: Text(
                        reasonName[value]!,
                        style: const TextStyle(color: Colors.black),
                      ),
                      icon: Icon(reasonIcons[value]!),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.onPrimary),
                        iconColor: const WidgetStatePropertyAll(Colors.black),
                        shape: _indexR == value.index + 1
                            ? WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 5,
                                  ),
                                ),
                              )
                            : WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // commento
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: TextEditingController(text: _enteredComment),
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 60, horizontal: 5),
                  border: OutlineInputBorder(),
                  hintText: 'Commento',
                ),
                maxLines: null,
                onChanged: (value) => _enteredComment = value,
              ),
            ),
            const SizedBox(height: 60),
            // invia
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 50,
                  child: FilledButton(
                    onPressed: () {
                      setState(() {
                        _isPressedI = true;
                        _saveItem();
                      });
                      final data = {
                        'isPressedI': _isPressedI,
                        'newSent': newSent
                      };
                      Navigator.of(context).pop(data);
                    },
                    child: const Text(
                      'Invia',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
