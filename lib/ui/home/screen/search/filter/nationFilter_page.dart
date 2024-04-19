import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_market/CustomIcon.dart';
import 'package:trip_market/world.dart';
import 'package:trip_market/provider/search_provider.dart';

class NationFilterPage extends ConsumerStatefulWidget {
  const NationFilterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NationFilterPageState();
}

class _NationFilterPageState extends ConsumerState<NationFilterPage> {
  List<String> nationList = World().nationList;
  Map<String, List<double>> nationLatLng = World().nationLatLng;
  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(100, 0),
    zoom: 4,
  );
  late GoogleMapController _selectedmap;
  String? selectedNation;

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
          '${AppLocalizations.of(context)!.nation} ${AppLocalizations.of(context)!.filter}',
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                clipBehavior: Clip.hardEdge,
                child: GoogleMap(
                  onMapCreated: (controller) {
                    setState(() {
                      _selectedmap = controller;
                    });
                  },
                  initialCameraPosition: _initialPosition,
                  myLocationEnabled: false,
                  myLocationButtonEnabled: false,
                  compassEnabled: false,
                  rotateGesturesEnabled: false,
                  zoomGesturesEnabled: false,
                  zoomControlsEnabled: false,
                  scrollGesturesEnabled: false,
                  mapType: MapType.normal,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      CustomIcon.search,
                      color: Colors.grey,
                      size: 18,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Autocomplete(
                        fieldViewBuilder: (context, textEditingController,
                            focusNode, onFieldSubmitted) {
                          return TextFormField(
                            controller: textEditingController,
                            focusNode: focusNode,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppLocalizations.of(context)!.search,
                            ),
                            onFieldSubmitted: (String value) {
                              onFieldSubmitted();
                            },
                          );
                        },
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text == '') {
                            return const Iterable<String>.empty();
                          }
                          return nationList.where(
                            (text) {
                              return text.toLowerCase().contains(
                                  textEditingValue.text.toLowerCase());
                            },
                          );
                        },
                        onSelected: (String selection) {
                          setState(() {
                            selectedNation = selection;
                          });
                          _selectedmap.animateCamera(
                            CameraUpdate.newLatLng(
                              LatLng(
                                nationLatLng[selection]![0],
                                nationLatLng[selection]![1],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: selectedNation == null ? Colors.grey[100] : Colors.black45,
        elevation: 0,
        child: InkWell(
          onTap: () {
            if (selectedNation != null) {
              ref
                  .read(searchTripProvider)
                  .setNationFilter(nation: selectedNation!);
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
                  color: selectedNation == null ? Colors.black : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
