import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trip_market/CustomIcon.dart';
import 'package:trip_market/ui/login/login_widgets.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentUser = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        initialData: currentUser,
        builder: (context, snapshot) {
          if (currentUser != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          }
          return Scaffold(
              backgroundColor: Colors.white,
              body: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 88.h, 16.w, 83.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //logo
                      LoginWidgets().logo(),
                      //Sign in with Google
                      LoginWidgets().googleSignInButton(),
                      const SizedBox(height: 20),
                      //Sign in with Apple
                      LoginWidgets().appleSignInButton(),
                      const SizedBox(height: 20),
                      //Sign in with Facebook
                      LoginWidgets().facebookSignInButton(),
                    ],
                  ),
                ),
              ));
        });
  }
}
