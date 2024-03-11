import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_market/provider/myPage_provider.dart';

class PlanMyTripPage extends ConsumerStatefulWidget {
  const PlanMyTripPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlanMyTripPageState();
}

class _PlanMyTripPageState extends ConsumerState<PlanMyTripPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> profileProvider = ref.watch(profile)!;
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
          AppLocalizations.of(context)!.planMyTrip,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: const SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.only(top: 44, bottom: 34),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
      ),
    );
  }
}
