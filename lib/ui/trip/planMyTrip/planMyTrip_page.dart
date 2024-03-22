import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_market/provider/myPage_provider.dart';
import 'package:trip_market/CustomIcon.dart';
import 'package:trip_market/viewModel/trip/planMyTrip_viewmodel.dart';
import 'package:trip_market/ui/trip/planMyTrip/selectPlaceMapView_page.dart';
import 'package:trip_market/model/trip_model.dart';

part 'planMyTrip_widgets.dart';

class PlanMyTripPage extends ConsumerWidget {
  const PlanMyTripPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Trip planData = ref.watch(tripProvider).trip!;
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () {
          removeOverlay();
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
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
            elevation: 0,
            backgroundColor: Colors.white,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: TextButton(
                  onPressed: () async {
                    //save
                    await ref.read(tripProvider).requestSaveMyPlan().then(
                      (result) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context2) {
                              return AlertDialog(
                                content: result
                                    ? Text(AppLocalizations.of(context)!
                                        .saveSucceed)
                                    : Text(AppLocalizations.of(context)!
                                        .saveFailed),
                              );
                            });
                      },
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context)!.save,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 34),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Trip title
                TripTitleWidget(),
                const SizedBox(height: 20),
                //Destination
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.destination,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Text(
                        planData.nation,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                //Trip duration
                TripDurationWidget(),
                const SizedBox(height: 20),
                const Divider(
                  color: Colors.grey,
                  height: 20,
                  thickness: 2,
                ),
                //Trip Planner
                PlanOfDaysWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
