import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_market/provider/myPage_provider.dart';
import 'package:trip_market/CustomIcon.dart';
import 'package:trip_market/model/trip_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

part 'tripPlan_widgets.dart';

class TripPlanPage extends ConsumerWidget {
  const TripPlanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            IconButton(
              onPressed: () async {
                //edit this trip
                //navigator to planMyTrip Page with this Trip
              },
              icon: const FaIcon(
                FontAwesomeIcons.solidPenToSquare,
                color: Colors.black,
                size: 21,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: IconButton(
                onPressed: () async {
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
                              ref.read(myTripListProvider).removeAtMyTripList(
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
                },
                icon: const FaIcon(
                  FontAwesomeIcons.trash,
                  color: Colors.black,
                  size: 21,
                ),
              ),
            )
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
