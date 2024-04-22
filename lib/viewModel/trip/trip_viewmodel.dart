import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trip_market/data/repository/gallery/gallery_repository.dart';
import 'package:trip_market/model/trip_model.dart';
import 'package:trip_market/provider/myPage_provider.dart';

class TripViewModel extends ChangeNotifier {
  Trip? _trip;

  Trip? get trip => _trip;

  tripInitialization(String nation) {
    _trip = Trip.initial(nation: nation);
    notifyListeners();
  }

  modifyTripData({required Trip modifiedTripData}) {
    _trip = modifiedTripData;
    notifyListeners();
  }

  Future<bool> requestSaveMyPlan({
    required WidgetRef ref,
    bool? modify,
  }) async {
    bool result = false;
    Map<String, dynamic> modifyData = Map.from(trip!.planOfDay);
    List<String> plans = modifyData.keys.toList();
    for (String plan in plans) {
      List<dynamic> eachDay = List.from(modifyData[plan]!);
      int count = eachDay.length;
      for (int i = 0; i < count; i++) {
        Map<String, dynamic> eachPlan = Map.from(eachDay[i]);
        var imageFile = eachPlan['image'];
        String imageName = '${_trip!.docName}-$plan-$i';
        if (imageFile != null && imageFile.runtimeType != String) {
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
    Trip convertTrip = trip!.copyWith(planOfDay: modifyData);

    try {
      ref
          .read(myTripListProvider)
          .addMyTripList(
            trip: convertTrip,
            modify: modify,
          )
          .then((_) {
        result = true;
      });
    } catch (e) {
      result = false;
    }

    return result;
  }
}
