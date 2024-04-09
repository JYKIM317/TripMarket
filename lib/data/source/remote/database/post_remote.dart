import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trip_market/data/source/remote/database/firestore/firestore_post_remote.dart';
import 'package:trip_market/data/source/remote/database/firestore/firestore_user_remote.dart';

class FirestorePostRemote {
  Future<DocumentSnapshot?> getUserPostedTrip({required String uid}) async {
    final String address = '$uid/myPost/trip';

    return await FirestoreUserDocumentRemote(address: address)
        .getUserDocumentData();
  }

  Future<void> setUserPostedTrip(
      {required String uid, required Map<String, dynamic> json}) async {
    final String address = '$uid/myPost/trip';

    await FirestoreUserDocumentRemote(address: address)
        .setUserDocumentData(json: json);
  }

  Future<void> setTripPost({required Map<String, dynamic> json}) async {
    final String address = json['docName'];
    await FirestorePostDocumentRemote(address: address)
        .setPostDocumentData(json: json);
  }

  Future<void> deleteTripPost({required String docName}) async {
    final String address = docName;
    await FirestorePostDocumentRemote(address: address)
        .deletePostDocumentData();
  }
}
