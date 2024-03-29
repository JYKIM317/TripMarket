import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:trip_market/data/repository/gallery/gallery_repository.dart';
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

  Map<dynamic, List<TextEditingController>> textEditingControllerGenerator(
      Map<String, dynamic> planOfDay) {
    Map<dynamic, List<TextEditingController>> controllers = {};

    List<String> days = planOfDay.keys.toList();

    for (int i = 0; i < days.length; i++) {
      int dayOfPlanCount = planOfDay['$i'].length;
      List<TextEditingController> detailControllers = [];
      for (int j = 0; j < dayOfPlanCount; j++) {
        TextEditingController textController = TextEditingController();
        textController.text = planOfDay['$i'][j]['detail'] ?? '';
        detailControllers.add(textController);
      }
      controllers[i] = detailControllers;
    }

    return controllers;
  }
}
