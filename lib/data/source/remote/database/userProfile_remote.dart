import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trip_market/data/source/remote/database/firestore/firestore_user_remote.dart';

class FirestoreUserProfileRemote {
  Future<DocumentSnapshot?> getUserProfileDoc({required String uid}) async {
    final String address = uid;

    return await FirestoreUserDocumentRemote(address: address)
        .getUserDocumentData();
  }

  Future<void> setUserProfileDoc({required Map<String, dynamic> json}) async {
    final String address = json['uid'];

    await FirestoreUserDocumentRemote(address: address)
        .setUserDocumentData(json: json);
  }

  Future<void> updateUserProfileDoc({
    required Map<String, dynamic> json,
  }) async {
    final String address = json['uid'];

    await FirestoreUserDocumentRemote(address: address)
        .updateUserDocumentData(json: json);
  }
}

class FirestoreLoginHistoryRemote {
  Future<void> updateUserLastLoginHistory(
      {required Map<String, dynamic> json}) async {
    final String address = json['uid'];

    await FirestoreUserDocumentRemote(address: address)
        .updateUserDocumentData(json: json);
  }
}
