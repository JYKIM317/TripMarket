import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trip_market/analytics.dart';

class FirestorePostDocumentRemote {
  final String collectionName = 'post';
  late String address;

  FirestorePostDocumentRemote({required this.address});

  Future<DocumentSnapshot?> getPostDocumentData() async {
    try {
      return await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(address)
          .get();
    } catch (e) {
      await Analytics().logEvent(
        logName: 'Firestore post doc remote get data exeption',
        log: {'exeption': e.toString()},
      );

      return null;
    }
  }

  Future<void> setPostDocumentData({required Map<String, dynamic> json}) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(address)
          .set(json);
    } catch (e) {
      await Analytics().logEvent(
        logName: 'Firestore post doc remote set data exeption',
        log: {'exeption': e.toString()},
      );
    }
  }

  Future<void> deletePostDocumentData() async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(address)
          .delete();
    } catch (e) {
      await Analytics().logEvent(
        logName: 'Firestore post doc remote delete data exeption',
        log: {'exeption': e.toString()},
      );
    }
  }
}

class FirestorePostCollectionRemote {
  late String address;

  FirestorePostCollectionRemote({required this.address});

  Future<QuerySnapshot?> getPostCollectionDoc() async {
    try {
      return await FirebaseFirestore.instance.collection(address).get();
    } catch (e) {
      await Analytics().logEvent(
        logName: 'Firestore post collection remote get data exeption',
        log: {'exeption': e.toString()},
      );

      return null;
    }
  }
}
