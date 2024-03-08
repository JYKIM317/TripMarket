import 'dart:convert';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypto/crypto.dart';
import 'package:trip_market/data/source/remote/auth/auth_remote.dart';

class FirebaseAuthRepository {
  Future<UserCredential> signInWithGoogle() async {
    return await AuthRemote().getGoogleCredential();
  }

  Future<UserCredential> signInWithApple() async {
    String generateNonce([int length = 32]) {
      const charset =
          '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
      final random = Random.secure();
      return List.generate(
          length, (_) => charset[random.nextInt(charset.length)]).join();
    }

    String sha256ofString(String input) {
      final bytes = utf8.encode(input);
      final digest = sha256.convert(bytes);
      return digest.toString();
    }

    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    return await AuthRemote().getAppleCredential(
      rawNonce: rawNonce,
      nonce: nonce,
    );
  }

  Future<UserCredential> signInWithFacebook() async {
    return await AuthRemote().getFacebookCredential();
  }

  Future<void> signOutAuth() async {
    await FirebaseAuth.instance.signOut();
  }
}
