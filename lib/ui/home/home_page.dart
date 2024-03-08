import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:trip_market/CustomIcon.dart';
import 'package:trip_market/ui/home/screen/home/home_screen.dart';
import 'package:trip_market/ui/home/screen/search/search_screen.dart';
import 'package:trip_market/ui/home/screen/myPage/myPage_screen.dart';
import 'package:trip_market/viewModel/home/home_viewmodel.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int currentIndex = 0;
  onBottomTapped(int index) {
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  void initState() {
    HomeViewModel().requestUpdateLastLoginHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        onTap: onBottomTapped,
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
