import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:trip_market/CustomIcon.dart';
import 'package:trip_market/provider/home_provider.dart';
import 'package:trip_market/ui/home/screen/home/home_screen.dart';
import 'package:trip_market/ui/home/screen/search/search_screen.dart';
import 'package:trip_market/ui/home/screen/myPage/myPage_screen.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentIndex = ref.watch(homeProvider)!;
    ref.read(homeProvider.notifier).requestUpdateLastLoginHistory();
    return Scaffold(
      backgroundColor: Colors.white,
      body: [
        HomeScreen(),
        SearchScreen(),
        MyPageScreen(),
      ][currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CustomIcon.home, size: 28),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcon.search, size: 21),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcon.user, size: 21),
            label: 'My',
          ),
        ],
        currentIndex: currentIndex,
        onTap: ref.read(homeProvider.notifier).selectIndex,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
