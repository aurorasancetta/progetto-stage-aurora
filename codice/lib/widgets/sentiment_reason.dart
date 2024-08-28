import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_at_work/models/sentiment.dart';

class SentimentReason extends StatefulWidget {
  const SentimentReason(this.pressed, {super.key});

  final int pressed;

  @override
  State<SentimentReason> createState() => _SentimentReasonState();
}

class _SentimentReasonState extends State<SentimentReason> {
  int indexC = 999;
  int indexR = 999;
  String sentC = ' ';
  String why = ' ';

  @override
  void initState() {
    indexC = widget.pressed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (indexC == 1) {
      sentC = typeName[Type.entusiasta]!;
      why = 'Cosa ha influito positivamente?';
    } else if (indexC == 2) {
      sentC = typeName[Type.soddisfatto]!;
      why = 'Cosa ha influito positivamente?';
    } else if (indexC == 3) {
      sentC = typeName[Type.insoddisfatto]!;
      why = 'Cosa ha influito negativamente?';
    } else if (indexC == 4) {
      sentC = typeName[Type.frustrato]!;
      why = 'Cosa ha influito negativmente?';
    }

    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Come va oggi?',
            style: GoogleFonts.ptSerif(
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
                      indexC = (value.index + 1);
                    });
                  },
                  icon: indexC == value.index + 1
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
            child: Text(sentC),
          ),
          const SizedBox(height: 20),
          // motivazioni sentiment
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 10),
              Text(
                why,
                style: GoogleFonts.lato(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 60,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              scrollDirection: Axis.horizontal,
              children: [
                for (var value in Reason.values)
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        indexR = (value.index + 1);
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
                      shape: indexR == value.index + 1
                          ? WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
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
            child: const TextField(
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 60, horizontal: 5),
                border: OutlineInputBorder(),
                hintText: 'Commento',
              ),
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
                    onPressed: () {},
                    child: const Text(
                      'Invia',
                      style: TextStyle(fontSize: 18),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
