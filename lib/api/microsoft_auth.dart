import 'dart:convert';
import 'package:http/http.dart' as http;

Future fetchAzureUserDetails(accessToken) async {
  http.Response response;
  response = await http.get(
    Uri.parse("https://graph.microsoft.com/v1.0/me"),
    headers: {"Authorization": "Bearer $accessToken"},
  );

  Map<String, dynamic> resposeBody =
      json.decode(response.body) as Map<String, dynamic>;
  print(resposeBody);
}

Future getLogged() async {
  // test user loggato
  return Future.value(true);
}
