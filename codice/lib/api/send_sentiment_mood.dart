import 'dart:convert';

import 'package:happy_at_work/models/mood.dart';
import 'package:happy_at_work/models/sentiment.dart';
import 'package:http/http.dart' as http;

enum Status { ok, ko }

class SendResult {
  const SendResult({
    required this.status,
    this.message,
  });

  final Status status;
  final String? message;
}

String getStatus(Map<String, dynamic> resultObject) {
  return resultObject['status'];
}

String getStatusMessage(Map<String, dynamic> resultObject) {
  return resultObject['messaggio'];
}

Future<SendResult> sendSentimentToday(String email, Sentiment sentiment) async {
  int typeInt;
  int? reasonInt;

  switch (sentiment.type) {
    case SType.entusiasta:
      typeInt = 1;
      break;
    case SType.soddisfatto:
      typeInt = 2;
      break;
    case SType.insoddisfatto:
      typeInt = 3;
      break;
    case SType.frustrato:
      typeInt = 4;
      break;
  }

  switch (sentiment.reason) {
    case null:
      reasonInt = null;
      break;
    case Reason.task:
      reasonInt = 1;
      break;
    case Reason.collega:
      reasonInt = 2;
      break;
    case Reason.fas:
      reasonInt = 3;
      break;
    case Reason.mioTeam:
      reasonInt = 4;
      break;
    case Reason.altroTeam:
      reasonInt = 5;
      break;
    case Reason.altro:
      reasonInt = 6;
      break;
  }

  http.Response result = await http.post(
    Uri.parse('https://happyatwork.cgn.it/API/InserimentoFaccina.php'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: <String, Object?>{
      'EmailUtente': email,
      'TipoFaccina': "$typeInt",
      'NoteFaccina': sentiment.comment,
      'MetricaSentiment': "$reasonInt",
    },
  );

  if (result.statusCode == 200) {
    Map<String, dynamic> resultObject =
        jsonDecode(result.body) as Map<String, dynamic>;
    String status = getStatus(resultObject);
    String message = getStatusMessage(resultObject);
    if (status == 'KO') {
      return SendResult(status: Status.ko, message: message);
    } else if (status == 'OK') {
      return const SendResult(status: Status.ok);
    }
  } else {
    return SendResult(status: Status.ko, message: result.reasonPhrase);
  }
  return const SendResult(
      status: Status.ko, message: 'Errore | qualcosa è andato storto');
}

Future<SendResult> sendMoodToday(String email, MType moodType) async {
  int? typeInt;

  switch (moodType) {
    case MType.energico:
      typeInt = 1;
      break;
    case MType.divertito:
      typeInt = 2;
      break;
    case MType.felice:
      typeInt = 3;
      break;
    case MType.sereno:
      typeInt = 4;
      break;
    case MType.stanco:
      typeInt = 5;
      break;
    case MType.annoiato:
      typeInt = 6;
      break;
    case MType.stressato:
      typeInt = 7;
      break;
    case MType.triste:
      typeInt = 8;
      break;
    case MType.arrabbiato:
      typeInt = 9;
      break;
  }

  http.Response result = await http.post(
    Uri.parse('https://happyatwork.cgn.it/API/InserimentoMood.php'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: <String, Object?>{
      'EmailUtente': email,
      'Mood': "$typeInt",
    },
  );

  if (result.statusCode == 200) {
    Map<String, dynamic> resultObject =
        jsonDecode(result.body) as Map<String, dynamic>;
    String status = getStatus(resultObject);
    String message = getStatusMessage(resultObject);
    if (status == 'KO') {
      return SendResult(status: Status.ko, message: message);
    } else if (status == 'OK') {
      return const SendResult(status: Status.ok);
    }
  } else {
    return SendResult(status: Status.ko, message: result.reasonPhrase);
  }
  return const SendResult(
      status: Status.ko, message: 'Errore | qualcosa è andato storto');
}
