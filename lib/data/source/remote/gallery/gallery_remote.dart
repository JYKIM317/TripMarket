import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageRemote {
  Future<String> uploadImageToStorageReturnUrl({
    required String uid,
    required String imageName,
    required File imageFile,
  }) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('user')
        .child(uid)
        .child(imageName);
    final uploadTask = ref.putFile(imageFile);
    final snapshot = await uploadTask.whenComplete(() {});
    return await snapshot.ref.getDownloadURL();
  }
}
