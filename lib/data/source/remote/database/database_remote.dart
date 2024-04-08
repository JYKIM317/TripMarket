import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trip_market/data/source/remote/database/firestore_user_remote.dart';

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

class FirestorePostRemote {
  Future<DocumentSnapshot?> getUserPostedTrip({required String uid}) async {
    final String address = '$uid/myPost/trip';

    return await FirestoreUserDocumentRemote(address: address)
        .getUserDocumentData();
  }
}
