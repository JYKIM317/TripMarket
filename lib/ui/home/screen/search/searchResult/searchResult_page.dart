import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_market/model/trip_model.dart';
import 'package:trip_market/provider/search_provider.dart';

class SearchResultPage extends ConsumerWidget {
  const SearchResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Trip>? searchTripList = ref.watch(searchTripProvider).searchTripList;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        titleSpacing: 0,
        title: Text(
          AppLocalizations.of(context)!.searchResult,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
