import 'package:aad_oauth/model/config.dart';
import 'package:aad_oauth/model/failure.dart';
import 'package:aad_oauth/model/token.dart';
import 'package:flutter/material.dart';
import 'package:aad_oauth/aad_oauth.dart';
import 'package:happy_at_work/api/microsoft_auth.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final Config config = Config(
  tenant: "52b05f4e-ca61-4e07-860c-6ad265cf2514",
  clientId: "6c649fd2-ea96-4b52-8ea3-9be298d24792",
  scope: "openid profile offline_access",
  redirectUri: "happyatwork://loginredirect",
  loader: const Center(child: CircularProgressIndicator()),
  navigatorKey: navigatorKey,
);

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => getLogged(), //_azureSignInApi(),
          child: const Text('log in'),
        ),
      ),
    );
  }

  Future _azureSignInApi() async {
    final AadOAuth oauth = AadOAuth(config);

    final result = await oauth.login();

    result.fold(
      (Failure failure) => print('error failure'),
      (Token token) {
        if (token.accessToken == null) {
          print('error | missing acces token');
          return;
        }

        // handle succesful login
        print(
            'Logged in succesfully, your acces token:  ${token.accessToken!}');
      },
    );
    // Perform necessary actions with the access token, such as API calls or storing it securely.
  }
}
