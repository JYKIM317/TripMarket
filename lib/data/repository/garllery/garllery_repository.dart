import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:trip_market/data/source/local/garllery/garllery_local.dart';
import 'package:trip_market/data/source/remote/garllery/garllery_remote.dart';

class LocalGarlleryRepository {
  Future<XFile?> getImageFile() async {
    XFile? selectedImage = await LocalGarllery().getImageFromGarllery();

    return selectedImage;
  }
}

class RemoteGarlleryRepository {
  Future<String> uploadAndGetImageUrl({
    required String imageName,
    required File imageFile,
  }) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseStorageRemote().uploadImageToStorageReturnUrl(
      uid: uid,
      imageName: imageName,
      imageFile: imageFile,
    );
  }
}

Future<Uint8List> compressImage({
  required String filePath,
  required int quality,
}) async {
  Uint8List? result = await FlutterImageCompress.compressWithFile(
    filePath,
    quality: quality,
  );
  return result!;
}
