import 'dart:convert';
import 'package:happy_at_work/models/user.dart';
import 'package:http/http.dart' as http;

Future fetchAzureUserDetails(accessToken) async {
  http.Response response;
  response = await http.get(
    Uri.parse("https://graph.microsoft.com/v1.0/me"),
    headers: {"Authorization": "Bearer $accessToken"},
  );

  return json.decode(response.body);
}

Future getLogged() async {
  // test user loggato
  return Future.value(true);
}
