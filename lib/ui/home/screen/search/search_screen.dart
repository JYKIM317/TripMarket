import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:trip_market/ui/home/screen/search/search_screen_widgets.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.only(top: 84),
      child: const Column(
        children: [
          SearchBarWidget(),
          SizedBox(height: 10),
          SearchFilterWidget(),
          SizedBox(height: 40),
          SearchHistoryWidget(),
        ],
      ),
    );
  }
}
