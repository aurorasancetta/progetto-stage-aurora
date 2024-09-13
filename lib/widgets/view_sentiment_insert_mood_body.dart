import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_at_work/api/send_sentiment_mood.dart';
import 'package:happy_at_work/models/mood.dart';
import 'package:happy_at_work/models/sentiment.dart';
import 'package:happy_at_work/providers/user_provider.dart';
import 'package:happy_at_work/screens/second_choice.dart';

class ViewSentimentInsertMoodBody extends ConsumerWidget {
  const ViewSentimentInsertMoodBody({
    super.key,
    required this.sentiment,
    required this.onModResultSentiment,
    required this.onModResultMood,
    this.mood,
  });

  final Sentiment sentiment;
  final void Function(SendResult) onModResultSentiment;
  final void Function(SendResult) onModResultMood;
  final Mood? mood;

  void _modSentiment(BuildContext ctx) async {
    final data = await Navigator.of(ctx).push(MaterialPageRoute(
      builder: (ctx) => SecondChoiceScreen(sentiment.type.index + 1, sentiment),
    ));
    onModResultSentiment(data);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SENTIMENT DI OGGI',
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    _modSentiment(context);
                  },
                  icon: Icon(
                    Icons.edit_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  label: Text(
                    'Modifica',
                    style: GoogleFonts.lato(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(color: Theme.of(context).colorScheme.surface),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Puoi modificare il sentiment entro la fine della giornata corrente',
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.onPrimary,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 48,
                          width: 48,
                          child: Image.asset(typeImage[sentiment.type]!),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          typeName[sentiment.type]!,
                          style: GoogleFonts.lato(
                            color: Theme.of(context).colorScheme.outline,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          reasonIcons[sentiment.reason],
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          sentiment.reason == null
                              ? ''
                              : reasonName[sentiment.reason]!,
                          style: GoogleFonts.lato(
                            color: Theme.of(context).colorScheme.outline,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  sentiment.comment == null || sentiment.comment == ''
                      ? 'Commento non inserito'
                      : sentiment.comment!,
                  style: GoogleFonts.lato(
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context).colorScheme.outline,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 56),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 8),
              Text(
                'IL TUO UMORE',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
          Divider(color: Theme.of(context).colorScheme.surface),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 8),
              Text(
                'Puoi condividere come ti senti oggi, al di la del lavoro',
                style: GoogleFonts.lato(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          DropdownMenu(
            width: double.infinity,
            hintText: 'Seleziona',
            textStyle: GoogleFonts.lato(
              fontSize: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
            initialSelection: mood?.type,
            inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: Theme.of(context).colorScheme.onPrimary),
            leadingIcon: mood == null
                ? const Icon(Icons.sentiment_satisfied_alt)
                : Icon(moodIcon[mood!.type]),
            onSelected: (MType? newMoodType) async {
              // manda mood ad api
              final data = await sendMoodToday(user, newMoodType!);
              onModResultMood(data);
            },
            dropdownMenuEntries: MType.values
                .map(
                  (value) => DropdownMenuEntry(
                    value: value,
                    label: moodName[value]!,
                    leadingIcon: Image.asset(
                      moodImage[value]!,
                      height: 24,
                    ),
                    style: ButtonStyle(
                      textStyle: WidgetStatePropertyAll(
                        GoogleFonts.lato(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
