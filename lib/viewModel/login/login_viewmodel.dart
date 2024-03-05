import 'package:trip_market/data/repository/auth_repository.dart';

class LoginViewModel {
  Future<void> requestSignInWithGoogle() async {
    await FirebaseAuthRepository().signInWithGoogle();
  }

  Future<void> requestSignInWithApple() async {
    await FirebaseAuthRepository().signInWithApple();
  }

  Future<void> requestSignInWithFaceBook() async {
    await FirebaseAuthRepository().signInWithFacebook();
  }
}
