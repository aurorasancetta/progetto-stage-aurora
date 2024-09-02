enum MType {
  energico,
  divertito,
  felice,
  sereno,
  stanco,
  annoiato,
  stressato,
  tiste,
  arrabbiato
}

class Mood {
  const Mood({this.type, this.date});

  final MType? type;
  final DateTime? date;
}
