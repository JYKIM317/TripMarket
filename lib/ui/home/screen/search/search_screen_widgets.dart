import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trip_market/CustomIcon.dart';
import 'package:trip_market/provider/search_provider.dart';
import 'package:trip_market/ui/home/screen/search/filter/nationFilter_page.dart';
import 'package:trip_market/ui/home/screen/search/filter/tripDurationFilter_page.dart';
import 'package:trip_market/ui/home/screen/search/searchResult/searchResult_page.dart';

class SearchBarWidget extends ConsumerStatefulWidget {
  const SearchBarWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchBarWidgetState();
}

class _SearchBarWidgetState extends ConsumerState<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(
              CustomIcon.search,
              color: Colors.grey,
              size: 18,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                maxLines: 1,
                controller: _controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: AppLocalizations.of(context)!.search,
                ),
                onSubmitted: (text) {
                  String element = text.trim();
                  _controller.text = '';
                  ref.read(searchTripProvider).searchInitialization();
                  ref.read(searchTripProvider).searchTrip(search: element);
                  ref
                      .read(searchHistoryProvider)
                      .addMySearchHistory(element: element);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchResultPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchFilterWidget extends ConsumerWidget {
  const SearchFilterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color deActivateBackgroundColor = Colors.grey[300]!;
    Color deActivateFontColor = Colors.black;
    Color activateBackgroundColor = Colors.black;
    Color activateFontColor = Colors.white;

    String? nationFilter = ref.watch(searchTripProvider).nationFilter;
    int? durationFilter = ref.watch(searchTripProvider).durationFilter;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {
              ref.read(searchTripProvider).filterInitialization();
            },
            icon: const FaIcon(
              FontAwesomeIcons.filterCircleXmark,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 8),
          //Nation filter
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NationFilterPage(),
                  ),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: nationFilter == null
                      ? deActivateBackgroundColor
                      : activateBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        nationFilter ?? AppLocalizations.of(context)!.nation,
                        style: TextStyle(
                          fontSize: 16,
                          color: nationFilter == null
                              ? deActivateFontColor
                              : activateFontColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const FaIcon(
                      FontAwesomeIcons.caretDown,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          //Duration filter
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TripDurationFilterPage(),
                  ),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: durationFilter == null
                      ? deActivateBackgroundColor
                      : activateBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${durationFilter ?? AppLocalizations.of(context)!.tripDuration}',
                        style: TextStyle(
                          fontSize: 16,
                          color: durationFilter == null
                              ? deActivateFontColor
                              : activateFontColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const FaIcon(
                      FontAwesomeIcons.caretDown,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchHistoryWidget extends ConsumerWidget {
  const SearchHistoryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String>? searchHistory =
        ref.watch(searchHistoryProvider).searchHistory;
    searchHistory ?? ref.read(searchHistoryProvider).fetchMySearchHistory();

    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.searchHistory,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                physics: const ClampingScrollPhysics(),
                itemCount: searchHistory?.length ?? 0,
                itemBuilder: (BuildContext ctx, int idx) {
                  return SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            ref.read(searchTripProvider).searchInitialization();
                            ref
                                .read(searchTripProvider)
                                .searchTrip(search: searchHistory[idx]);
                            ref.read(searchHistoryProvider).addMySearchHistory(
                                element: searchHistory[idx]);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchResultPage(),
                              ),
                            );
                          },
                          child: Text(
                            searchHistory![idx],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            ref
                                .read(searchHistoryProvider)
                                .removeMySearchHistory(index: idx);
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (ctx, idx) {
                  return const SizedBox(height: 10);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
