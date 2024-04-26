import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:trip_market/model/trip_model.dart';
import 'package:trip_market/provider/home_provider.dart';
import 'package:trip_market/ui/home/screen/home/home_screen_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_market/provider/search_provider.dart';
import 'package:trip_market/provider/myPage_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  onScroll() {
    bool reachMaxExtent =
        _scrollController.offset >= _scrollController.position.maxScrollExtent;
    bool outOfRange = !_scrollController.position.outOfRange &&
        _scrollController.position.pixels != 0;

    if (reachMaxExtent && outOfRange) {
      ref.read(recommendProvider).getTrip();
    }
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      onScroll();
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Trip>? recommendTripList =
        ref.watch(recommendProvider).recommendTripList;
    Map<String, dynamic>? myInterestTag =
        ref.watch(myInterestProvider).myInterestTag;
    Map<String, dynamic>? myInterestDestination =
        ref.watch(myInterestProvider).myInterestDestination;
    List<String>? searchHistory =
        ref.watch(searchHistoryProvider).searchHistory;

    myInterestTag ?? ref.read(myInterestProvider).fetchMyInterestTag();
    myInterestDestination ??
        ref.read(myInterestProvider).fetchMyInterestDestination();
    searchHistory ?? ref.read(searchHistoryProvider).fetchMySearchHistory();

    bool fetchYet = myInterestTag == null ||
        myInterestDestination == null ||
        searchHistory == null;

    if (recommendTripList == null && !fetchYet) {
      ref.read(recommendProvider).getTrip(
            myInterestTag: myInterestTag,
            myInterestDestination: myInterestDestination,
            searchHistory: searchHistory,
          );
    }

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        controller: _scrollController,
        slivers: [
          const SliverToBoxAdapter(child: MainBannerWidget()),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                AppLocalizations.of(context)!.recommendForYou,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          //random recommend widget
          const RecommendGridWidget(),
          const SliverToBoxAdapter(child: SizedBox(height: 44)),
        ],
      ),
    );
  }
}
