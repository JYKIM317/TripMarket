import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:trip_market/ui/home/screen/myPage/myPage_screen_widgets.dart';

class MyPageScreen extends ConsumerWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.only(top: 44, bottom: 34),
        child: Column(
          children: [
            MyPageScreenWidgets().myProfile(),
            const SizedBox(height: 10),
            MyPageScreenWidgets().myFeature(),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 16,
              color: Colors.grey[100],
            ),
            const SizedBox(height: 10),
            MyPageScreenWidgets().recentWatch(),
            const SizedBox(height: 10),
            MyPageScreenWidgets().myTravelPlans(),
            const SizedBox(height: 10),
            MyPageScreenWidgets().favoritePlan(),
          ],
        ),
      ),
    );
  }
}
