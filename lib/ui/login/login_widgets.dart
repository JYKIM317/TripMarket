import 'package:flutter/material.dart';
import 'package:trip_market/CustomIcon.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_market/viewModel/login/login_viewmodel.dart';

class LoginWidgets {
  Widget logo(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        //logo part
        child: Text(
          AppLocalizations.of(context)!.tripMarket,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 48,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget googleSignInButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        await LoginViewModel().requestSignInWithGoogle();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 0.5,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset(
                'assets/images/g-logo.png',
                width: 24,
              ),
            ),
            Center(
              child: Text(
                AppLocalizations.of(context)!.signInWithGoogle,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget appleSignInButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        await LoginViewModel().requestSignInWithApple();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                CustomIcon.apple,
                color: Colors.white,
                size: 24,
              ),
            ),
            Center(
              child: Text(
                AppLocalizations.of(context)!.signInWithApple,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget facebookSignInButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        await LoginViewModel().requestSignInWithFaceBook();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                CustomIcon.facebook,
                color: Colors.white,
                size: 24,
              ),
            ),
            Center(
              child: Text(
                AppLocalizations.of(context)!.signInWithFacebook,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
