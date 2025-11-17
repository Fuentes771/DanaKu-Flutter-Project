import 'package:firebase_auth/firebase_auth.dart';
import '../interfaces.dart';

class FirebaseAuthRepository implements IAuthRepository {
  final FirebaseAuth _auth;
  FirebaseAuthRepository(this._auth);

  @override
  Future<bool> isLoggedIn() async => _auth.currentUser != null;

  @override
  Future<void> login({required String email, required String password}) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> register({
    required String email,
    required String password,
  }) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  @override
  String? get userId => _auth.currentUser?.uid;
}
