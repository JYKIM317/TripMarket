import 'package:firebase_auth/firebase_auth.dart';
import 'package:trip_market/model/trip_model.dart';
import 'package:trip_market/provider/myPage_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:trip_market/ui/trip/tripPlan/tripPlan_page.dart';

class MyTripPostPage extends ConsumerWidget {
  const MyTripPostPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    List<Trip>? myTripList = ref.watch(myTripListProvider).tripList;
    List<String>? myPostedTripList = ref.watch(postProvider).postList;
    myPostedTripList ?? ref.read(postProvider).fetchMyPostList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
          AppLocalizations.of(context)!.myPost,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ListView.separated(
          physics: const ClampingScrollPhysics(),
          itemCount: myTripList!.length,
          padding: const EdgeInsets.only(top: 44, bottom: 34),
          itemBuilder: (BuildContext ctx, int idx) {
            Trip thisTrip = myTripList[idx];
            String? thisImage = thisTrip.planOfDay['0'][0]['image'];
            double imageWidth = (MediaQuery.sizeOf(context).width - 32);
            double imageHeight = imageWidth * 0.7;
            bool? isPosted =
                myPostedTripList?.contains(thisTrip.docName) ?? false;
            if (uid != thisTrip.uid) {
              return const SizedBox(height: 0);
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      // Navigator to TripPlan Page
                      ref
                          .read(tripProvider)
                          .modifyTripData(modifiedTripData: thisTrip);
                      ref.read(planOfDaysIndex.notifier).selectIndex(0);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TripPlanPage(),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: double.infinity,
                      height: imageHeight,
                      child: Stack(
                        children: [
                          Container(
                            width: imageWidth,
                            height: imageHeight,
                            clipBehavior: Clip.hardEdge,
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
                            child: Hero(
                              tag: thisTrip.docName,
                              child: thisImage != null
                                  ? CachedNetworkImage(
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
                                    )
                                  : Center(
                                      child: Icon(
                                        Icons.image,
                                        size: imageWidth / 5,
                                        color: Colors.white,
                                      ),
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
                                Container(
                                  width: double.infinity,
                                  color: Colors.white.withOpacity(0.8),
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 20),
                                  child: Text(
                                    thisTrip.title,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,
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
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              isPosted
                                  ? AppLocalizations.of(context)!.postShared
                                  : AppLocalizations.of(context)!.postNotShared,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        //share state
                        InkWell(
                          onTap: () {
                            isPosted
                                ? ref
                                    .read(postProvider)
                                    .deleteSharedMyTrip(trip: thisTrip)
                                : ref
                                    .read(postProvider)
                                    .shareMyTrip(trip: thisTrip);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: Text(
                              isPosted
                                  ? AppLocalizations.of(context)!.cancelSharing
                                  : AppLocalizations.of(context)!.share,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (ctx, idx) {
            Trip thisTrip = myTripList[idx];
            if (uid != thisTrip.uid) {
              return const SizedBox(height: 0);
            }
            return const Divider(
              color: Colors.grey,
              thickness: 1,
              height: 40,
            );
          },
        ),
      ),
    );
  }
}
