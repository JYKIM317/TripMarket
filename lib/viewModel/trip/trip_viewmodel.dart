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
    Trip tripData = _trip!;
    List<String> plans = tripData.planOfDay.keys.toList();
    for (String plan in plans) {
      int count = tripData.planOfDay[plan]?.length ?? 0;
      for (int i = 0; i < count; i++) {
        File imageFile = tripData.planOfDay[plan]![i]['image'];
        String imageName = '${tripData.docName}-$plan-$i';
        String imageUrl = await RemoteGarlleryRepository().uploadAndGetImageUrl(
          imageName: imageName,
          imageFile: imageFile,
        );
        tripData.planOfDay[plan]![i]['image'] = imageUrl;
      }
    }

    return true;
    //return FirestoreRepository().setPlanData(data: tripData);
  }
}
