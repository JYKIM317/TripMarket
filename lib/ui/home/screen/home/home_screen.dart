import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:trip_market/ui/home/screen/home/home_screen_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_market/model/trip_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Trip>?
        recommendTripList; //= ref.watch(recommendTripProvider).tripList;
    // recommendTripList ?? ref.read(recommendTripProvider).fetchData();
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.only(top: 84, bottom: 44),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MainBannerWidget(),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                AppLocalizations.of(context)!.recommendForYou,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
            //random recommend widget
            RecommendGridWidget(
              tripList: recommendTripList,
            ),
          ],
        ),
      ),
    );
  }
}
