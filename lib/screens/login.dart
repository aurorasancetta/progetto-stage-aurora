import 'package:aad_oauth/model/config.dart';
import 'package:aad_oauth/model/failure.dart';
import 'package:aad_oauth/model/token.dart';
import 'package:flutter/material.dart';
import 'package:aad_oauth/aad_oauth.dart';
import 'package:happy_at_work/api/microsoft_auth.dart';
import 'package:microsoft_graph_api/microsoft_graph_api.dart';

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

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _azureSignInApi(),
              child: const Text('log in'),
            ),
            ElevatedButton(
                onPressed: () async {
                  await oauth.logout();
                  print('logged out');
                },
                child: const Text('log out'))
          ],
        ),
      ),
    );
  }

  Future _azureSignInApi() async {
    final result = await oauth.login();

    result.fold(
      (Failure failure) => print('error failure'),
      (Token token) async {
        if (token.accessToken == null) {
          print('error | missing acces token');
          return;
        }

        // handle succesful login
        print(
            'Logged in succesfully, your acces token:  ${token.accessToken!}');
        MSGraphAPI graphAPI = MSGraphAPI(token.accessToken!);
        print(await graphAPI.me.fetchUserInfo());
        //print(token.idToken.toString());
        //print(token.tokenType.toString());
        //print(token.refreshToken.toString());
        //fetchAzureUserDetails(token.accessToken);
      },
    );
    // Perform necessary actions with the access token, such as API calls or storing it securely.
  }
}
