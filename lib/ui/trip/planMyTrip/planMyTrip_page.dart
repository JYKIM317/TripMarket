import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_market/model/user_model.dart';
import 'package:trip_market/provider/myPage_provider.dart';
import 'package:trip_market/CustomIcon.dart';
import 'package:trip_market/viewModel/trip/planMyTrip_viewmodel.dart';
import 'package:trip_market/ui/trip/planMyTrip/selectPlaceMapView_page.dart';

part 'planMyTrip_widgets.dart';

class PlanMyTripPage extends ConsumerStatefulWidget {
  final Map<String, dynamic>? planData;
  final String? docName;
  const PlanMyTripPage({
    super.key,
    this.planData,
    this.docName,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlanMyTripPageState();
}

class _PlanMyTripPageState extends ConsumerState<PlanMyTripPage> {
  TextEditingController titleController = TextEditingController();
  late String title, docName;
  Map<String, dynamic>? planData;
  String temporaryDocName = 'tripPlan_${Random().nextInt(4294967296)}';

  @override
  void initState() {
    planData = widget.planData;
    docName = planData?['docName'] ?? temporaryDocName;
    title = planData?['title'] ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProfile profile = ref.watch(profileProvider).userProfile!;

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
                    await PlanMyTripViewModel()
                        .requestSaveMyPlan(
                      docName: docName,
                      title: title,
                      tripDuration: ref.watch(newTripDuration)!,
                      uid: profile.uid!,
                      nation: profile.nation!,
                      planData: ref.watch(planOfDayData)!,
                    )
                        .then((result) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context2) {
                            return AlertDialog(
                              content: result
                                  ? const Text('Save success')
                                  : const Text('Save fail'),
                            );
                          });
                    });
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
                Text(
                  AppLocalizations.of(context)!.tripTitle,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
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
                  child: TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
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
                        profile.nation!,
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
