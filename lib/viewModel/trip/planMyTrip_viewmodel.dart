import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:trip_market/data/repository/garllery/garllery_repository.dart';
import 'package:trip_market/data/repository/location/location_repository.dart';

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
}
