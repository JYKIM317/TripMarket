import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:trip_market/model/trip_model.dart';
import 'package:trip_market/provider/myPage_provider.dart'; //trip
import 'package:trip_market/provider/home_provider.dart';
import 'package:trip_market/ui/trip/tripPlan/tripPlan_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/*
  수집하는 데이터 
  - Search history
  - Search or main 에서 들어간 post info history
*/

class RecommendGridWidget extends ConsumerWidget {
  final List<dynamic>? tripList;
  const RecommendGridWidget({
    super.key,
    required this.tripList,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (tripList == null) {
      return const SliverToBoxAdapter(child: LoadingGridWidget());
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 24,
          mainAxisExtent: (MediaQuery.sizeOf(context).width / 1.6),
        ),
        delegate: SliverChildBuilderDelegate(
          childCount: tripList!.length,
          (BuildContext ctx, int idx) {
            Trip thisTrip = tripList![idx];
            var thisImage = thisTrip.planOfDay['0'][0]['image'];
            return InkWell(
              onTap: () {
                //initialization trip page
                ref
                    .read(tripProvider)
                    .modifyTripData(modifiedTripData: thisTrip);
                ref.read(planOfDaysIndex.notifier).selectIndex(0);
                //Update my recent view trip
                ref.read(recentViewProvider).updateMyRecentView(trip: thisTrip);
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
                                      imageBuilder: (context, imageProvider) {
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.8),
                                      borderRadius: const BorderRadius.vertical(
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
        ),
      ),
    );
  }
}

class LoadingGridWidget extends StatelessWidget {
  const LoadingGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 10,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 24,
        mainAxisExtent: (MediaQuery.sizeOf(context).width / 2),
      ),
      itemBuilder: (BuildContext ctx, int idx) {
        return Container(
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
        );
      },
    );
  }
}

//

class MainBannerWidget extends ConsumerStatefulWidget {
  const MainBannerWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MainBannerWidgetState();
}

class _MainBannerWidgetState extends ConsumerState<MainBannerWidget> {
  @override
  Widget build(BuildContext context) {
    List<dynamic>? banner = ref.watch(bannerProvider).bannerList;
    banner ?? ref.read(bannerProvider).fetchMyBannerList();

    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).width / 1.8,
      color: Colors.grey,
      child: banner != null
          ? PageView.builder(
              physics: const ClampingScrollPhysics(),
              pageSnapping: true,
              itemCount: banner.length,
              itemBuilder: (BuildContext ctx, int idx) {
                return Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CachedNetworkImage(
                      imageUrl: banner[idx],
                      imageBuilder: (context, imageProvider) {
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
                    Padding(
                      padding: const EdgeInsets.only(right: 16, bottom: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${idx + 1} / ${banner.length}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
          : null,
    );
  }
}
