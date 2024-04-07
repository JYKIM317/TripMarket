import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:trip_market/CustomIcon.dart';
import 'package:trip_market/model/trip_model.dart';
import 'package:trip_market/ui/settings/settings_page.dart';
import 'package:trip_market/ui/home/screen/myPage/editMyProfile/editMyProfile_page.dart';
import 'package:trip_market/ui/trip/planMyTrip/planMyTrip_page.dart';
import 'package:trip_market/provider/myPage_provider.dart';
import 'package:trip_market/model/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:trip_market/ui/home/screen/myPage/ownTripList/ownTripList_page.dart';
import 'package:trip_market/ui/trip/tripPlan/tripPlan_page.dart';
import 'package:trip_market/ui/home/screen/myPage/myTripPost/myTripPost_page.dart';

class MyPageScreenWidgets {
  Widget myProfile() {
    return Consumer(
      builder: (context, ref, child) {
        UserProfile? profile = ref.watch(profileProvider).userProfile;
        if (profile == null) {
          ref.read(profileProvider).fetchUserProfile();
          return loadingProfile(context);
        }

        return Container(
          width: double.infinity,
          height: 120,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Hero(
                        tag: 'profile',
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: profile.profileImage != null
                              ? Image.memory(
                                  base64Decode(profile.profileImage!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ref.watch(profileProvider).userProfile!.name!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              profile.nation!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                //Edit Profile
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditMyProfilePage(),
                                  ),
                                );
                                //ref.read(profile.notifier).remove();
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.editProfile,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.grey,
                                      size: 18,
                                    ),
                                  ],
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
              Container(
                height: double.infinity,
                alignment: Alignment.topCenter,
                child: IconButton(
                  onPressed: () {
                    //Settings
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.menu_rounded,
                    color: Colors.black,
                    size: 32,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget myFeature() {
    return Consumer(
      builder: (context, ref, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            width: double.infinity,
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 1,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    UserProfile profile =
                        ref.watch(profileProvider).userProfile!;
                    String currentNation = profile.nation ?? '';
                    if (currentNation != '') {
                      ref.read(tripProvider).tripInitialization(currentNation);
                      ref.read(planOfDaysIndex.notifier).selectIndex(0);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlanMyTripPage(),
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            const Icon(
                              CustomIcon.map_o,
                              color: Colors.white,
                              shadows: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 2,
                                )
                              ],
                              size: 24,
                            ),
                            Transform.translate(
                              offset: const Offset(7, -8),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                shadows: [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 2,
                                  )
                                ],
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          AppLocalizations.of(context)!.planNewTrip,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyTripPostPage(),
                      ),
                    );
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          CustomIcon.user_edit,
                          color: Colors.white,
                          shadows: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 2,
                            )
                          ],
                          size: 24,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          AppLocalizations.of(context)!.myPost,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        CustomIcon.edit,
                        color: Colors.white,
                        shadows: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 2,
                          )
                        ],
                        size: 24,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        AppLocalizations.of(context)!.writeReview,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget recentWatch() {
    return Consumer(
      builder: (context, ref, child) {
        return Container(
          width: double.infinity,
          height: 260,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.recentView,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              //Local Data Source Repository랑 연결
            ],
          ),
        );
      },
    );
  }

  Widget myTravelPlans() {
    return Consumer(
      builder: (context, ref, child) {
        List<Trip>? myTripList = ref.watch(myTripListProvider).tripList;
        if (myTripList == null) {
          ref.read(myTripListProvider).fetchMyTripList();
          return loadingMyTrip(context);
        }
        return Container(
          width: double.infinity,
          height: 260,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.travelPlansYouHave,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OwnTripListPage(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black,
                      size: 21,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  physics: const ClampingScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                  scrollDirection: Axis.horizontal,
                  itemCount: myTripList.length,
                  itemBuilder: (BuildContext ctx, int idx) {
                    Trip thisTrip = myTripList[idx];
                    var thisImage = thisTrip.planOfDay['0'][0]['image'];
                    bool isFile = thisImage.runtimeType != String;
                    return InkWell(
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
                      child: Container(
                        height: double.infinity,
                        width: 300,
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
                                      child: isFile
                                          ? Image.file(
                                              thisImage,
                                              fit: BoxFit.cover,
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: thisTrip.planOfDay['0']
                                                  [0]['image'],
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
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.8),
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
                                  Container(
                                    width: double.infinity,
                                    height: 50,
                                    color: Colors.white.withOpacity(0.8),
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
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
                    );
                  },
                  separatorBuilder: (ctx, idx) {
                    return const SizedBox(width: 10);
                  },
                ),
              ),
              //Remote Data Source Repository랑 연결
            ],
          ),
        );
      },
    );
  }

  Widget favoritePlan() {
    return Consumer(
      builder: (context, ref, child) {
        return Container(
          width: double.infinity,
          height: 260,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.favoriteTravelPlans,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black,
                      size: 21,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              //Local Data Source Repository랑 연결
            ],
          ),
        );
      },
    );
  }
}

/* ------------------- */

Widget loadingProfile(BuildContext context) {
  return Container(
    width: double.infinity,
    height: 120,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Container(
      height: double.infinity,
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    '',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    '',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.editProfile,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.grey,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget loadingMyTrip(BuildContext context) {
  return Container(
    width: double.infinity,
    height: 260,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              AppLocalizations.of(context)!.travelPlansYouHave,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 21,
                fontWeight: FontWeight.w500,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
                size: 21,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                width: 300,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 20),
              Container(
                width: 300,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 20),
              Container(
                width: 300,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
