import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trip_market/data/source/remote/database/firestore/firestore_user_remote.dart';

class FirestoreTripRemote {
  Future<void> saveMyTripDoc({
    required String uid,
    required Map<String, dynamic> json,
  }) async {
    final String address = '$uid/myTrip/${json['docName']}';

    await FirestoreUserDocumentRemote(address: address)
        .setUserDocumentData(json: json);
  }

  Future<void> deleteMyTripDoc({
    required String uid,
    required String docName,
  }) async {
    final String address = '$uid/myTrip/$docName';

    await FirestoreUserDocumentRemote(address: address)
        .deleteUserDocumentData();
  }

  Future<QuerySnapshot?> getUserTripList({required String uid}) async {
    final String address = 'user/$uid/myTrip';

    return await FirestoreUserCollectionRemote(address: address)
        .getUserCollectionDoc();
  }
}
