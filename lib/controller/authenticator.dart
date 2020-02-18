import 'package:firebase_auth/firebase_auth.dart';

class Authenticator {
  static FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> signup(String email, String password) async {
    var result = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user.uid;
  }

  Future<AuthResult> login(String email, String password) async {
    var result = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return result;
  }

  Future<void> logout() async {
    auth.signOut();
  }
}
