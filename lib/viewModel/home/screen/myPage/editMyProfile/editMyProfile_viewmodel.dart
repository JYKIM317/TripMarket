import 'dart:convert';
import 'dart:typed_data';
import 'package:trip_market/data/repository/database/database_repository.dart';
import 'package:trip_market/data/repository/garllery/garllery_repository.dart';

class EditMyProfileViewModel {
  Future<String?> requestUpdateProfileImage() async {
    Uint8List? imageFile = await LocalGarlleryRepository().getImageFile();
    String? base64Image;
    if (imageFile != null) {
      base64Image = base64Encode(imageFile);
      //base64Image = await RemoteGarlleryRepostory().uploadAndGetImageUrl(imageFile: imageFile);

      Map<String, dynamic> data = {'profileImage': base64Image};
      FirestoreRepository().updateUserData(data: data);
    }

    return base64Image;
  }

  Future<void> requestUpdateProfileName({required String name}) async {
    Map<String, dynamic> data = {'name': name};
    FirestoreRepository().updateUserData(data: data);
  }
}
