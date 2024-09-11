import 'package:happy_at_work/models/mood.dart';
import 'package:happy_at_work/models/sentiment.dart';

// enum UType { employee, fas, hr }

class User {
  const User({
    required this.name,
    required this.surname,
    required this.email,
    required this.team,
    this.mood,
    this.sentiment,
  });

  final String name;
  final String surname;
  final String email;
  final String team;
  // final UType userType;
  final Mood? mood;
  final Sentiment? sentiment;
}
