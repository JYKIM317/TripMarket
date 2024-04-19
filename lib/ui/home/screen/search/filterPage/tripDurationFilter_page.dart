import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_market/provider/search_provider.dart';

class TripDurationFilterPage extends ConsumerStatefulWidget {
  const TripDurationFilterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TripDurationFilterPageState();
}

class _TripDurationFilterPageState
    extends ConsumerState<TripDurationFilterPage> {
  int? selectedDuration;
  List<int> dayList = List.generate(31, (index) => index + 1);

  @override
  Widget build(BuildContext context) {
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
          '${AppLocalizations.of(context)!.tripDuration} ${AppLocalizations.of(context)!.filter}',
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ListView.separated(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 44),
          itemCount: dayList.length,
          itemBuilder: (BuildContext ctx, int idx) {
            int thisDay = dayList[idx];
            return InkWell(
              onTap: () {
                setState(() {
                  selectedDuration = thisDay;
                });
              },
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: selectedDuration == thisDay
                      ? Colors.grey[200]
                      : Colors.transparent,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  dayList[idx].toString(),
                  style: const TextStyle(fontSize: 21),
                ),
              ),
            );
          },
          separatorBuilder: (ctx, idx) {
            return const SizedBox(height: 10);
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: selectedDuration == null ? Colors.grey[100] : Colors.black45,
        elevation: 0,
        child: InkWell(
          onTap: () {
            if (selectedDuration != null) {
              ref
                  .read(searchTripProvider)
                  .setDurationFilter(duration: selectedDuration!);
              Navigator.pop(context);
            }
          },
          child: Container(
            height: 70,
            alignment: Alignment.center,
            //alignment: Alignment.center,
            child: Center(
              child: Text(
                '${AppLocalizations.of(context)!.set} ${AppLocalizations.of(context)!.filter}',
                style: TextStyle(
                  fontSize: 24,
                  color: selectedDuration == null ? Colors.black : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
