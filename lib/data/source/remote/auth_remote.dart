import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthRemote {
  Future<UserCredential> getGoogleCredential() async {
    GoogleSignInAccount? googleSignIn = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await googleSignIn?.authentication;

    OAuthCredential oauthCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

  Future<UserCredential> getAppleCredential({
    required String rawNonce,
    required String nonce,
  }) async {
    String redirectionURL =
        "https://foregoing-halved-falcon.glitch.me/callbacks/sign_in_with_apple";
    String clientId = "tripmarket.delivalue.com";

    AuthorizationCredentialAppleID appleCredential =
        await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId: clientId,
        redirectUri: Uri.parse(redirectionURL),
      ),
      nonce: nonce,
    );

    OAuthCredential oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
      rawNonce: rawNonce,
    );

    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

  Future<UserCredential> getFacebookCredential() async {
    LoginResult facebookAuth = await FacebookAuth.instance.login();

    OAuthCredential oauthCredential =
        FacebookAuthProvider.credential(facebookAuth.accessToken!.token);

    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }
}
