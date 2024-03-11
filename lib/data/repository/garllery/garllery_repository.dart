import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:trip_market/data/source/local/garllery/garllery_local.dart';
//import 'package:trip_market/data/source/remote/garllery/garllery_remote.dart';

class LocalGarlleryRepository {
  Future<Uint8List?> getImageFile() async {
    XFile? selectedImage = await LocalGarllery().getImageFromGarllery();
    Uint8List? profileImage;

    if (selectedImage != null) {
      for (int q = 90; q > 10; q - 10) {
        Uint8List compressedImage =
            await compressImage(filePath: selectedImage.path, quality: q);

        if (compressedImage.lengthInBytes < 1028487) {
          //firestore doc limit size is 1,048,487
          profileImage = compressedImage;
          break;
        }
      }
    }

    return profileImage;
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
