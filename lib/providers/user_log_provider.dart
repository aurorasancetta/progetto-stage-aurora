import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happy_at_work/api/send_sentiment_mood.dart';
import 'package:happy_at_work/models/user.dart';
import 'package:happy_at_work/screens/shared.dart';
import 'package:happy_at_work/api/microsoft_auth.dart' as auth;

class UserLog {
  User? _user;
  AuthState _authState = AuthState.none;
  String? _errorMessage;

  static UserLog loggedIn(User user) {
    var log = UserLog();
    log._user = user;
    log._authState = AuthState.loggedIn;
    return log;
  }

  static UserLog loggedOut() {
    var log = UserLog();
    log._user = null;
    log._errorMessage = null;
    log._authState = AuthState.none;
    return log;
  }

  static UserLog logError(String errorMessage) {
    var log = UserLog();
    log._authState = AuthState.error;
    log._errorMessage = errorMessage;
    return log;
  }

  static UserLog loading() {
    var log = UserLog();
    log._authState = AuthState.loading;
    return log;
  }

  User getUser() {
    if (_authState == AuthState.loggedIn) {
      return _user!;
    }

    throw ArgumentError('Errore | stato diverso da loggedIn');
  }

  isLogging() {
    if (_authState == AuthState.loading) {
      return true;
    }
    return false;
  }

  isError() {
    if (_authState == AuthState.error) {
      return true;
    }
    return false;
  }

  getErrorMessage() {
    if (isError()) {
      return _errorMessage!;
    }

    throw ArgumentError('Errore | stato diverso da error');
  }

  bool isLoggedIn() {
    if (_authState == AuthState.loggedIn) {
      return true;
    }
    return false;
  }

  bool isNone() {
    if (_authState == AuthState.none) {
      return true;
    }
    return false;
  }
}

class UserNotifier extends StateNotifier<UserLog> {
  UserNotifier() : super(UserLog());

  void login() async {
    state = UserLog.loading();
    var result = await auth.login();
    if (result.status == Status.ok) {
      state = UserLog.loggedIn(
          User(email: result.email!, nameSurname: result.nameSurname!));
    } else {
      state = UserLog.logError(result.message!);
    }
  }

  void logout() async {
    await auth.logout();
    state = UserLog.loggedOut();
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserLog>((ref) {
  return UserNotifier();
});

/*final userProvider = Provider((ref) => const User(
    email: 'federico.moretto@cgn.it', nameSurname: 'Federico Moretto'));*/

