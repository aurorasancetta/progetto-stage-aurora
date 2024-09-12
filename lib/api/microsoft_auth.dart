import 'package:aad_oauth/model/config.dart';
import 'package:flutter/material.dart';
import 'package:aad_oauth/aad_oauth.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final Config config = Config(
  tenant: "52b05f4e-ca61-4e07-860c-6ad265cf2514",
  clientId: "6c649fd2-ea96-4b52-8ea3-9be298d24792",
  scope: "openid profile offline_access",
  redirectUri: "happyatwork://loginredirect",
  loader: const Center(child: CircularProgressIndicator()),
  navigatorKey: navigatorKey,
);

final AadOAuth oauth = AadOAuth(config);

/*class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _login(),
              child: const Text('log in'),
            ),
            /*ElevatedButton(
                onPressed: () async {
                  await oauth.logout();
                  print('logged out');
                },
                child: const Text('log out'))*/
          ],
        ),
      ),
    );
  }*/

Future login() async {
  var result = await oauth.login();
  result.fold(
    (failure) => debugPrint(failure.toString()),
    (token) {
      debugPrint("idToken: ${token.idToken}");
      _decodeJwt(token.idToken!);
    },
  );
}

Map<String, dynamic> _decodeJwt(String token) {
  Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

  final data = {
    'email': decodedToken["preferred_username"],
    'name_surname': decodedToken["name"],
  };
  return data;
  //debugPrint(decodedToken["preferred_username"]);
  //debugPrint(decodedToken["name"]);
}
