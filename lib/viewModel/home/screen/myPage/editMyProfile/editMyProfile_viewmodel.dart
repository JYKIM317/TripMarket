import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:trip_market/data/repository/database/database_repository.dart';
import 'package:trip_market/data/repository/garllery/garllery_repository.dart';
import 'package:trip_market/data/repository/location/location_repository.dart';
import 'package:trip_market/model/user_model.dart';

class EditMyProfileViewModel {
  Future<String?> requestUpdateProfileImage(
      {required UserProfile profile}) async {
    XFile? imageFile = await LocalGarlleryRepository().getImageFile();
    Uint8List? profileImage;
    String? base64Image;

    if (imageFile != null) {
      for (int q = 90; q > 10; q - 10) {
        Uint8List compressedImage =
            await compressImage(filePath: imageFile.path, quality: q);

        if (compressedImage.lengthInBytes < 1028487) {
          //firestore doc limit size is 1,048,487
          profileImage = compressedImage;
          break;
        }
      }

      base64Image = base64Encode(profileImage!);

      profile.profileImage = base64Image;
      FirestoreRepository().updateUserProfile(userProfile: profile);
    }

    return base64Image;
  }

  Future<void> requestUpdateProfileName({
    required UserProfile profile,
  }) async {
    FirestoreRepository().updateUserProfile(userProfile: profile);
  }

  Future<String> requestUpdateProfileNation(
      {required UserProfile profile}) async {
    String nation = await LocationRepository().getCurrentNation();
    profile.nation = nation;

    FirestoreRepository().updateUserProfile(userProfile: profile);
    return nation;
  }

  Future<LocationPermission> locationPermissionCheck() async {
    return await Geolocator.checkPermission();
  }
}
