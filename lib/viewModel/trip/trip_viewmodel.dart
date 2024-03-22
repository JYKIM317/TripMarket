import 'dart:io';
import 'package:flutter/material.dart';
import 'package:trip_market/data/repository/database/database_repository.dart';
import 'package:trip_market/data/repository/garllery/garllery_repository.dart';
import 'package:trip_market/model/trip_model.dart';

class TripViewModel extends ChangeNotifier {
  FirestoreRepository repository;
  Trip? _trip;

  Trip? get trip => _trip;

  TripViewModel(this.repository);

  tripInitialization(String nation) {
    _trip = Trip.initial(nation: nation);
    notifyListeners();
  }

  modifyTripData({required Trip modifiedTripData}) {
    _trip = modifiedTripData;
    notifyListeners();
  }

  Future<bool> requestSaveMyPlan() async {
    bool result = false;

    Map<String, List<dynamic>> modifyData = Map.from(trip!.planOfDay);

    List<String> plans = modifyData.keys.toList();
    for (String plan in plans) {
      List<dynamic> eachDay = List.from(modifyData[plan]!);
      int count = eachDay.length;
      for (int i = 0; i < count; i++) {
        Map<String, dynamic> eachPlan = Map.from(eachDay[i]);
        File? imageFile = eachPlan['image'];
        String imageName = '${_trip!.docName}-$plan-$i';
        if (imageFile != null && imageFile.runtimeType == File) {
          String imageUrl =
              await RemoteGarlleryRepository().uploadAndGetImageUrl(
            imageName: imageName,
            imageFile: imageFile,
          );

          eachPlan['image'] = imageUrl;
          eachDay[i] = eachPlan;
          modifyData[plan] = eachDay;
        }
      }
    }
    print('initial: ${trip!.planOfDay}');
    print('modify: ${modifyData}');

    Trip convertTrip = trip!.copyWith(planOfDay: modifyData);

    try {
      await FirestoreRepository().saveTrip(trip: convertTrip).then((value) {
        result = true;
      });
    } catch (e) {
      result = false;
    }

    return result;
  }
}
