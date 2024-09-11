import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_at_work/api/send_sentiment_mood.dart';
import 'package:happy_at_work/models/sentiment.dart';

class SecondChoiceScreen extends StatefulWidget {
  const SecondChoiceScreen(this.pressedC, this.sentiment, {super.key});

  final int pressedC;
  final Sentiment? sentiment;

  @override
  State<SecondChoiceScreen> createState() => _SecondChoiceScreenState();
}

class _SecondChoiceScreenState extends State<SecondChoiceScreen> {
  var _indexC = 999;
  var _indexR = 999;
  var _sentC = ' ';
  var _why = ' ';
  var _enteredComment = '';
  final _date = DateTime.now();
  Sentiment? newSent;

  void _saveItem() {
    newSent = Sentiment(
      type: SType.values[_indexC - 1],
      reason: Reason.values[_indexR - 1],
      comment: _enteredComment,
      date: _date,
    );
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
      _sentC = typeName[SType.entusiasta]!;
      _why = 'Cosa ha influito positivamente?';
    } else if (_indexC == 2) {
      _sentC = typeName[SType.soddisfatto]!;
      _why = 'Cosa ha influito positivamente?';
    } else if (_indexC == 3) {
      _sentC = typeName[SType.insoddisfatto]!;
      _why = 'Cosa ha influito negativamente?';
    } else if (_indexC == 4) {
      _sentC = typeName[SType.frustrato]!;
      _why = 'Cosa ha influito negativmente?';
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Come va oggi?',
              style: GoogleFonts.ptSerif(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
            const SizedBox(height: 48),
            // opzioni di sentiment
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var value in SType.values)
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _indexC = (value.index + 1);
                      });
                    },
                    icon: _indexC == value.index + 1
                        ? Container(
                            height: 72,
                            width: 72,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 5,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryFixedDim,
                                  blurRadius: 16,
                                  offset: const Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Image.asset(typeImage[value]!),
                          )
                        : SizedBox(
                            height: 72,
                            width: 72,
                            child: Image.asset(typeImage[value]!)),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              alignment: Alignment.center,
              height: 33,
              width: 112,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Theme.of(context).colorScheme.secondaryContainer),
                  color: Theme.of(context).colorScheme.onPrimary,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primaryFixedDim,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ]),
              child: Text(
                _sentC,
                style: GoogleFonts.lato(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
            ),
            const SizedBox(height: 40),
            // motivazioni sentiment
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 12),
                Text(
                  _why,
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 56,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                      ),
                      icon: Icon(reasonIcons[value]!),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.onPrimary),
                        iconColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.onSecondaryContainer),
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
            const SizedBox(height: 48),
            // commento
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                controller: TextEditingController(text: _enteredComment),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 64, horizontal: 8),
                  border: const OutlineInputBorder(),
                  hintText: 'Commento',
                  hintStyle: GoogleFonts.lato(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                maxLines: null,
                onChanged: (value) => _enteredComment = value,
              ),
            ),
            const SizedBox(height: 80),
            // invia
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 304,
                  height: 48,
                  child: FilledButton(
                    onPressed: () async {
                      // invio sentiment con api
                      setState(() {
                        _saveItem();
                      });
                      final data = await sendSentimentToday(
                          'federico.moretto@cgn.it', newSent!);
                      Navigator.of(context).pop(data);
                    },
                    child: Text(
                      'Invia',
                      style: GoogleFonts.lato(fontSize: 18),
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
