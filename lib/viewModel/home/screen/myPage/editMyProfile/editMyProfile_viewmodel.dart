import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:trip_market/data/repository/gallery/gallery_repository.dart';
import 'package:trip_market/data/repository/location/location_repository.dart';
import 'package:trip_market/model/user_model.dart';
import 'package:trip_market/provider/myPage_provider.dart';

class EditMyProfileViewModel {
  Future<void> requestUpdateProfileImage(
      {required UserProfile profile, required WidgetRef ref}) async {
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
      ref.read(profileProvider).updateUserProfile(profile: profile);
    }
  }

  Future<void> requestUpdateProfileName({
    required UserProfile profile,
    required WidgetRef ref,
  }) async {
    ref.read(profileProvider).updateUserProfile(profile: profile);
  }

  Future<void> requestUpdateProfileNation(
      {required UserProfile profile, required WidgetRef ref}) async {
    String nation = await LocationRepository().getCurrentNation();
    profile.nation = nation;

    ref.read(profileProvider).updateUserProfile(profile: profile);
  }

  Future<LocationPermission> locationPermissionCheck() async {
    return await Geolocator.checkPermission();
  }
}
