import 'dart:io';
import 'dart:convert';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:trip_market/data/repository/garllery/garllery_repository.dart';
import 'package:trip_market/data/repository/location/location_repository.dart';
import 'package:trip_market/data/repository/database/database_repository.dart';

class PlanMyTripViewModel {
  Future<File?> requestGetImageFile() async {
    XFile? image = await LocalGarlleryRepository().getImageFile();
    if (image != null) {
      return File(image.path);
    } else {
      return null;
    }
  }

  Future<Map<String, double>> requestGetMyPosition() async {
    return await LocationRepository().getMyPosition();
  }

  Future<String> requestGetThisAddress(
      {required double lat, required double lng}) async {
    return await LocationRepository().getThisPlaceAddress(lat: lat, lng: lng);
  }

  Future<bool> requestSaveMyPlan({
    required String docName,
    required String title,
    required int tripDuration,
    required String uid,
    required String nation,
    required Map<String, List<dynamic>> planData,
  }) async {
    List<String> plans = planData.keys.toList();
    for (String plan in plans) {
      int count = planData[plan]?.length ?? 0;
      for (int i = 0; i < count; i++) {
        File imageFile = planData[plan]![i]['image'];
        String imageName = '$docName-$plan-$i';
        String imageUrl = await RemoteGarlleryRepository().uploadAndGetImageUrl(
          imageName: imageName,
          imageFile: imageFile,
        );
        planData[plan]![i]['image'] = imageUrl;
      }
    }

    String planDataJson = jsonEncode(planData);
    Map<String, dynamic> data = {
      'docName': docName,
      'title': title,
      'tripDuration': tripDuration,
      'uid': uid,
      'nation': nation,
      'planData': planDataJson,
    };
    return true;
    //return FirestoreRepository().setPlanData(data: data);
  }
}
