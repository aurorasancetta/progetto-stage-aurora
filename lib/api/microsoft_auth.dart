import 'package:aad_oauth/model/config.dart';
import 'package:flutter/material.dart';
import 'package:aad_oauth/aad_oauth.dart';
import 'package:happy_at_work/api/send_sentiment_mood.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthResult {
  const AuthResult({
    required this.status,
    this.message,
    this.email,
    this.nameSurname,
  });

  final Status status;
  final String? message;
  final String? email;
  final String? nameSurname;
}

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

abstract class AuthManager {
  Future<AuthResult> login();
  Future<void> logout();
}

class MicrosoftAuthManager extends AuthManager {
  @override
  Future<AuthResult> login() async {
    var result = await oauth.login();
    var authResult = const AuthResult(
      status: Status.ko,
      message: 'Something went wrong',
    );

    result.fold(
      (failure) {
        authResult = AuthResult(
          status: Status.ko,
          message: failure.toString(),
        );
      },
      (token) {
        //debugPrint("idToken: ${token.idToken}");
        authResult = _decodeJwt(token.idToken!);
      },
    );
    return authResult;
  }

  AuthResult _decodeJwt(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    var data = AuthResult(
      status: Status.ok,
      email: decodedToken["preferred_username"],
      nameSurname: decodedToken["name"],
    );
    return data;
    //debugPrint(decodedToken["preferred_username"]);
    //debugPrint(decodedToken["name"]);
  }

  @override
  Future<void> logout() async {
    await oauth.logout();
  }
}

class TestAuthManager extends AuthManager {
  @override
  Future<AuthResult> login() {
    return Future.value(const AuthResult(
        status: Status.ok,
        email: "federico.moretto@cgn.it",
        nameSurname: "Federico"));
  }

  @override
  Future<void> logout() {
    return Future.value();
  }
}

// AuthManager authManager = TestAuthManager();
AuthManager authManager = MicrosoftAuthManager();

Future<AuthResult> login() {
  return authManager.login();
}

Future<void> logout() {
  return authManager.logout();
}
