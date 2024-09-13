import 'package:happy_at_work/models/mood.dart';
import 'package:happy_at_work/models/sentiment.dart';

// enum UType { employee, fas, hr }

class User {
  const User({
    required this.nameSurname,
    required this.email,
    this.team,
    this.mood,
    this.sentiment,
  });

  final String nameSurname;
  final String email;
  final String? team;
  // final UType userType;
  final Mood? mood;
  final Sentiment? sentiment;
}
