import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_market/provider/myPage_provider.dart';

part 'planMyTrip_widgets.dart';

class PlanMyTripPage extends ConsumerStatefulWidget {
  const PlanMyTripPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlanMyTripPageState();
}

class _PlanMyTripPageState extends ConsumerState<PlanMyTripPage> {
  TextEditingController titleController = TextEditingController();
  String? title;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> profileProvider = ref.watch(profile)!;
    return GestureDetector(
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
                onPressed: () {
                  //
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
              //Trip duration
              TripDurationWidget(),
              const SizedBox(height: 20),
              //Places
              Text(
                AppLocalizations.of(context)!.places,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                child: Text(profileProvider['nation']),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
