import 'package:flutter/material.dart';

enum MType {
  energico,
  divertito,
  felice,
  sereno,
  stanco,
  annoiato,
  stressato,
  triste,
  arrabbiato
}

final moodImage = {
  MType.energico: 'assets/emoji/energico.png',
  MType.divertito: 'assets/emoji/divertito.png',
  MType.felice: 'assets/emoji/felice.png',
  MType.sereno: 'assets/emoji/sereno.png',
  MType.stanco: 'assets/emoji/stanco.png',
  MType.annoiato: 'assets/emoji/annoiato.png',
  MType.stressato: 'assets/emoji/stressato.png',
  MType.triste: 'assets/emoji/triste.png',
  MType.arrabbiato: 'assets/emoji/arrabbiato.png',
};

final moodIcon = {
  MType.energico: Icons.sentiment_very_satisfied_outlined,
  MType.divertito: Icons.sentiment_very_satisfied_outlined,
  MType.felice: Icons.sentiment_satisfied_alt,
  MType.sereno: Icons.sentiment_satisfied,
  MType.stanco: Icons.sentiment_neutral,
  MType.annoiato: Icons.sentiment_neutral,
  MType.stressato: Icons.sentiment_very_dissatisfied_outlined,
  MType.triste: Icons.sentiment_dissatisfied_outlined,
  MType.arrabbiato: Icons.sentiment_very_dissatisfied_outlined,
};

final moodName = {
  MType.energico: 'Energico',
  MType.divertito: 'Divertito',
  MType.felice: 'Felice',
  MType.sereno: 'Sereno',
  MType.stanco: 'Stanco',
  MType.annoiato: 'Annoiato',
  MType.stressato: 'Stressato',
  MType.triste: 'Triste',
  MType.arrabbiato: 'Arrabbiato',
};

class Mood {
  const Mood({
    this.type,
  });

  final MType? type;
}
