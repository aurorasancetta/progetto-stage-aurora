import 'dart:convert';

import 'package:happy_at_work/models/mood.dart';
import 'package:happy_at_work/models/sentiment.dart';
import 'package:http/http.dart' as http;

class SentimentMoodResult {
  SentimentMoodResult({
    this.sentiment,
    this.errorMessage,
    this.mood,
  }) {
    if (sentiment != null && errorMessage != null) {
      throw ArgumentError(
          "Errore| non può essere che non ci sia ne un sentiment ne un messaggio di errore!");
    }
    if (sentiment == null && mood != null) {
      throw ArgumentError(
          'Errore | non può essere che ci sia un mood selezionato e nessun sentiment!');
    }
  }

  final Sentiment? sentiment;
  final String? errorMessage;
  final Mood? mood;

  bool isError() {
    if (errorMessage != null) {
      return true;
    }
    return false;
  }

  bool isSentimentSelected() {
    if (sentiment != null) {
      return true;
    }
    return false;
  }

  bool isMoodSelected() {
    if (isSentimentSelected() && mood != null) {
      return true;
    }
    return false;
  }
}

SentimentMoodResult? getSentimentMoodByResult(
    Map<String, dynamic> resultObject) {
  SType sType = SType.entusiasta;
  Reason? reason;
  MType? mType;

  if (resultObject['status'] == 'KO') {
    return SentimentMoodResult(errorMessage: resultObject['messaggio']);
  }

  if (resultObject['TipoFaccina'] == '0') {
    return null;
  }

  switch (resultObject['TipoFaccina']) {
    case '1':
      sType = SType.entusiasta;
      break;
    case '2':
      sType = SType.soddisfatto;
      break;
    case '3':
      sType = SType.insoddisfatto;
      break;
    case '4':
      sType = SType.frustrato;
      break;
  }

  switch (resultObject['MetricaSentiment']) {
    case '1':
      reason = Reason.task;
      break;
    case '2':
      reason = Reason.collega;
      break;
    case '3':
      reason = Reason.fas;
      break;
    case '4':
      reason = Reason.mioTeam;
      break;
    case '5':
      reason = Reason.altroTeam;
      break;
    case '6':
      reason = Reason.altro;
      break;
  }

  switch (resultObject['Mood']) {
    case '1':
      mType = MType.energico;
      break;
    case '2':
      mType = MType.divertito;
      break;
    case '3':
      mType = MType.felice;
      break;
    case '4':
      mType = MType.sereno;
      break;
    case '5':
      mType = MType.stanco;
      break;
    case '6':
      mType = MType.annoiato;
      break;
    case '7':
      mType = MType.stressato;
      break;
    case '8':
      mType = MType.triste;
      break;
    case '9':
      mType = MType.arrabbiato;
      break;
  }

  return SentimentMoodResult(
    sentiment: Sentiment(
      type: sType,
      reason: resultObject['MetricaSentiment'] == '0' ? null : reason,
      comment: resultObject['NoteFaccina'],
    ),
    mood: Mood(type: resultObject['Mood'] == '0' ? null : mType),
  );
}

Future<SentimentMoodResult> getSentimentMoodToday(String email) async {
  /* test errore 
  return Future.value(SentimentResult(errorMessage: 'Errore'));*/

  /* test loading 
  return Future.delayed(
      Duration(seconds: 10), () => SentimentResult(errorMessage: 'Errore'));*/

  /* test sentiment creato 
  return Future.value(SentimentResult(
      sentiment: const Sentiment(
    type: SType.entusiasta,
  ))); */

  /* test sentiment non inserito 
  return SentimentResult(); */

  http.Response result = await http.post(
    Uri.parse('https://happyatwork.cgn.it/API/GetFaccina.php'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: <String, Object>{
      'EmailUtente': email,
    },
  );

  if (result.statusCode == 200) {
    Map<String, dynamic> resultObject =
        jsonDecode(result.body) as Map<String, dynamic>;
    SentimentMoodResult? sentimentResult =
        getSentimentMoodByResult(resultObject);
    if (sentimentResult == null) {
      return SentimentMoodResult();
    }
    return sentimentResult;
  } else {
    return SentimentMoodResult(errorMessage: result.reasonPhrase);
  }
}
