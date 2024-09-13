import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:happy_at_work/models/user.dart';

/*class UserNotifier extends StateNotifier<User> {
  UserNotifier()
      : super(const User(
          email: 'federico.moretto@cgn.it',
          nameSurname: '',
        ));

  void updateUser(String email, String nameSurname) {
    state = User(email: email, nameSurname: nameSurname);
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  return UserNotifier();
});*/

final userProvider = Provider((ref) => const User(
    email: 'federico.moretto@cgn.it', nameSurname: 'Federico Moretto'));
