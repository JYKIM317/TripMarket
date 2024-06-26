import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_market/model/user_model.dart';
import 'package:trip_market/provider/myPage_provider.dart';
import 'package:trip_market/CustomIcon.dart';
import 'package:trip_market/model/trip_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trip_market/ui/trip/planMyTrip/planMyTrip_page.dart';
import 'package:trip_market/viewModel/trip/planMyTrip_viewmodel.dart';
import 'package:trip_market/ui/fullScreenImage/fullScreenImage_page.dart';

part 'tripPlan_widgets.dart';

class TripPlanPage extends ConsumerWidget {
  const TripPlanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Trip thisTrip = ref.watch(tripProvider).trip!;
    List<String>? myTripNameList =
        ref.watch(myTripListProvider).tripDocNameList;
    UserProfile? profile = ref.watch(profileProvider).userProfile;
    List<String>? myFavoriteTripList =
        ref.watch(favoriteProvider).favoriteTripNameList;
    List<dynamic>? myPostList = ref.watch(postProvider).postList;

    profile ?? ref.read(profileProvider).fetchUserProfile();
    myTripNameList ?? ref.read(myTripListProvider).fetchMyTripList();
    myFavoriteTripList ?? ref.read(favoriteProvider).fetchMyFavoriteDocName();
    myPostList ?? ref.read(postProvider).fetchMyPostList();

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
          actions: [
            //edit trip button
            if (thisTrip.uid == profile!.uid &&
                myTripNameList!.contains(thisTrip.docName))
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: IconButton(
                  onPressed: () async {
                    //edit this trip
                    //navigator to planMyTrip Page with this Trip
                    Map<dynamic, List<TextEditingController>> controllers =
                        PlanMyTripViewModel()
                            .textEditingControllerGenerator(thisTrip.planOfDay);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlanMyTripPage(
                          controllers: controllers,
                          modify: true,
                        ),
                      ),
                    );
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.solidPenToSquare,
                    color: Colors.black,
                    size: 21,
                  ),
                ),
              ),
            //remove trip button
            if (myTripNameList!.contains(thisTrip.docName))
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: IconButton(
                  onPressed: () async {
                    if (myPostList!.contains(thisTrip.docName)) {
                      //Can't remove it
                      showDialog(
                        context: context,
                        builder: (BuildContext context2) {
                          return AlertDialog(
                            content:
                                Text(AppLocalizations.of(context)!.postShared),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context2);
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.yes,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      //remove this trip
                      showDialog(
                        context: context,
                        builder: (BuildContext context2) {
                          return AlertDialog(
                            content: Text(
                                AppLocalizations.of(context)!.areYouSureRemove),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context2);
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.cancel,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  ref
                                      .read(myTripListProvider)
                                      .removeAtMyTripList(
                                          trip: ref.read(tripProvider).trip!);
                                  Navigator.pop(context2);
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.remove,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.trash,
                    color: Colors.black,
                    size: 21,
                  ),
                ),
              ),
            //favorite trip button
            if (thisTrip.uid != profile.uid &&
                !myTripNameList.contains(thisTrip.docName))
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: IconButton(
                  onPressed: () async {
                    ref.read(myTripListProvider).addMyTripList(trip: thisTrip);
                  },
                  icon: Text(
                    AppLocalizations.of(context)!.save,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            //favorite trip button
            if (thisTrip.uid != profile.uid &&
                !myTripNameList.contains(thisTrip.docName))
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: IconButton(
                  onPressed: () async {
                    String docName = thisTrip.docName;
                    myFavoriteTripList.contains(docName)
                        ? ref
                            .read(favoriteProvider)
                            .removeMyFavoriteTrip(docName: docName)
                        : ref
                            .read(favoriteProvider)
                            .addMyFavoriteTrip(docName: docName);
                  },
                  icon: FaIcon(
                    myFavoriteTripList!.contains(thisTrip.docName)
                        ? FontAwesomeIcons.solidHeart
                        : FontAwesomeIcons.heart,
                    color: Colors.red,
                    size: 21,
                  ),
                ),
              ),
          ],
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 34),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TripPlanPageWidgets().tripTitleWidget(),
              const SizedBox(height: 20),
              TripPlanPageWidgets().destinationWidget(),
              const SizedBox(height: 20),
              const Divider(
                color: Colors.grey,
                height: 20,
                thickness: 2,
              ),
              PlanOfDaysWidget(),
            ],
          ),
        ));
  }
}
