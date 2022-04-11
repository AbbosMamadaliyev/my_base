import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<UserModel?> signinWithEmailAndPass(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return UserModel.fromFirebase(user!);
    } catch (e) {
      print('error: $e');
    }
  }

  Future<UserModel?> registerWithEmailAndPass(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return UserModel.fromFirebase(user!);
    } catch (e) {
      print('error: $e');
    }
  }

  Future logOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('is_login_in', false);
    await _auth.signOut();
  }

  Stream<UserModel?> get currentUser {
    return _auth
        .authStateChanges()
        .map((user) => user != null ? UserModel.fromFirebase(user) : null);
  }
}
