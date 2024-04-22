import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_market/model/trip_model.dart';
import 'package:trip_market/provider/myPage_provider.dart';
import 'package:trip_market/provider/search_provider.dart';
import 'package:trip_market/ui/trip/tripPlan/tripPlan_page.dart';
import 'package:trip_market/ui/home/screen/home/home_screen_widgets.dart';

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
        child: searchTripList != null
            ? GridView.builder(
                physics: const ClampingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 44),
                itemCount: searchTripList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 24,
                  mainAxisExtent: (MediaQuery.sizeOf(context).width / 1.6),
                ),
                itemBuilder: (BuildContext ctx, int idx) {
                  Trip thisTrip = searchTripList[idx];
                  var thisImage = thisTrip.planOfDay['0'][0]['image'];
                  return InkWell(
                    onTap: () {
                      //initialization trip page
                      ref
                          .read(tripProvider)
                          .modifyTripData(modifiedTripData: thisTrip);
                      ref.read(planOfDaysIndex.notifier).selectIndex(0);
                      //Update my recent view trip
                      ref
                          .read(recentViewProvider)
                          .updateMyRecentView(trip: thisTrip);
                      //Update my interest
                      ref
                          .read(myInterestProvider)
                          .updateMyInterest(tagList: thisTrip.tag);
                      // Navigator to TripPlan Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TripPlanPage(),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            width: (MediaQuery.sizeOf(context).width - 40) / 2,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Stack(
                              children: [
                                Hero(
                                  tag: thisTrip.docName,
                                  child: thisImage != null
                                      ? SizedBox(
                                          width: double.infinity,
                                          height: double.infinity,
                                          child: CachedNetworkImage(
                                            imageUrl: thisTrip.planOfDay['0'][0]
                                                ['image'],
                                            imageBuilder:
                                                (context, imageProvider) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      : const Center(
                                          child: Icon(
                                            Icons.image,
                                            size: 64,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            borderRadius:
                                                const BorderRadius.vertical(
                                                    bottom: Radius.circular(8)),
                                          ),
                                          child: Text(
                                            thisTrip.nation,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            thisTrip.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            '${thisTrip.duration} ${AppLocalizations.of(context)!.days}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            : const LoadingGridWidget(),
      ),
    );
  }
}
