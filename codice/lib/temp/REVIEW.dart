import 'package:flutter/material.dart';
import 'package:happy_at_work/models/sentiment.dart';

class Review extends StatefulWidget {
  const Review(this.newSentiment, {super.key});

  final Sentiment newSentiment;

  @override
  State<Review> createState() {
    return _ReviewState();
  }
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    Sentiment newSentiment = widget.newSentiment;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(typeImage[newSentiment.type]!),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 200),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.edit_square),
                            ),
                          ],
                        ),
                        Text('Sentiment: ${typeName[newSentiment.type]!}'),
                        Text('Motivo: ${reasonName[newSentiment.reason]!}'),
                        if (newSentiment.comment != null)
                          SizedBox(
                            width: 250,
                            child: Text('Commento: ${newSentiment.comment!}'),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
