import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trip_market/viewModel/trip/planMyTrip_viewmodel.dart';
import 'package:trip_market/provider/myPage_provider.dart';
import 'package:trip_market/model/trip_model.dart';

class SelectPlaceMapView extends ConsumerStatefulWidget {
  final Map<String, dynamic> locationData;
  const SelectPlaceMapView({super.key, required this.locationData});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectPlaceMapViewState();
}

class _SelectPlaceMapViewState extends ConsumerState<SelectPlaceMapView> {
  late Map<String, dynamic> locationData;
  late GoogleMapController _selectedmap;
  late CameraPosition _initialPosition;
  double? selectLat, selectLng;

  Set<Marker> markers = {};
  _addMarker(cordinate) {
    setState(() {
      markers
          .add(Marker(position: cordinate, markerId: const MarkerId('1024')));
    });
  }

  @override
  void initState() {
    locationData = widget.locationData;
    _initialPosition = CameraPosition(
      target: LatLng(locationData['lat'], locationData['lng']),
      zoom: 10,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Trip planData = ref.watch(tripProvider).trip!;
    return Scaffold(
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
      ),
      body: GoogleMap(
        onTap: (cordinate) {
          _selectedmap.animateCamera(CameraUpdate.newLatLng(cordinate));
          _addMarker(cordinate);
          setState(() {
            selectLat = cordinate.latitude;
            selectLng = cordinate.longitude;
          });
        },
        onMapCreated: (controller) {
          setState(() {
            _selectedmap = controller;
          });
        },
        initialCameraPosition: _initialPosition,
        markers: markers,
        myLocationEnabled: true,
        mapType: MapType.normal,
      ),
      bottomNavigationBar: BottomAppBar(
        child: InkWell(
          onTap: () async {
            if (selectLat != null && selectLng != null) {
              String selectedDay = locationData['selectedDay'];
              int idx = locationData['idx'];
              await PlanMyTripViewModel()
                  .requestGetThisAddress(lat: selectLat!, lng: selectLng!)
                  .then((result) {
                Map<String, dynamic> temporaryData = planData.planOfDay;
                temporaryData[selectedDay]![idx]['location'] = result;
                temporaryData[selectedDay]![idx]['lat'] = selectLat;
                temporaryData[selectedDay]![idx]['lng'] = selectLng;

                ref
                    .read(tripProvider)
                    .modifyTripData(modifiedTripData: planData);

                Navigator.pop(context);
              });
            } else {
              showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                  content: Text('Please select the place on map'),
                ),
              );
            }
          },
          child: Container(
            height: 70,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 1,
                ),
              ],
            ),
            child: Text(
              AppLocalizations.of(context)!.selectThisLocation,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 21,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
