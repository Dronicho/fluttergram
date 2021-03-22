import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpFailed implements Exception {}

class LogInFailed implements Exception {}

class LogInWithGoogleFailed implements Exception {}

class LogOutFailed implements Exception {}

class AuthenticationRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthenticationRepository(
      {FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
      : _auth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  Future<void> signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException {
      throw SignUpFailed();
    } on PlatformException {
      throw SignUpFailed();
    }
  }

  Future<void> logInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final authentication = GoogleAuthProvider.credential(
          accessToken: googleAuth!.accessToken, idToken: googleAuth.idToken);
      await _auth.signInWithCredential(authentication);
    } on Exception {
      throw LogInWithGoogleFailed();
    }
  }

  Future<void> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on Exception {
      throw LogInFailed();
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } on Exception {
      throw LogOutFailed();
    }
  }
}
