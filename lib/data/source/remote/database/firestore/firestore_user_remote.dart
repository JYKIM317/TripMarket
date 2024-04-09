import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trip_market/analytics.dart';

class FirestoreUserDocumentRemote {
  final String collectionName = 'user';
  late String address;

  FirestoreUserDocumentRemote({required this.address});

  Future<DocumentSnapshot?> getUserDocumentData() async {
    try {
      return await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(address)
          .get();
    } catch (e) {
      await Analytics().logEvent(
        logName: 'Firestore user doc remote get data exeption',
        log: {'exeption': e.toString()},
      );

      return null;
    }
  }

  Future<void> setUserDocumentData({required Map<String, dynamic> json}) async {
    try {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(address)
          .set(json);
    } catch (e) {
      await Analytics().logEvent(
        logName: 'Firestore user doc remote set data exeption',
        log: {'exeption': e.toString()},
      );
    }
  }

  Future<void> updateUserDocumentData(
      {required Map<String, dynamic> json}) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(address)
          .update(json);
    } catch (e) {
      await Analytics().logEvent(
        logName: 'Firestore user doc remote update data exeption',
        log: {'exeption': e.toString()},
      );
    }
  }

  Future<void> deleteUserDocumentData() async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(address)
          .delete();
    } catch (e) {
      await Analytics().logEvent(
        logName: 'Firestore user doc remote delete data exeption',
        log: {'exeption': e.toString()},
      );
    }
  }
}

class FirestoreUserCollectionRemote {
  late String address;

  FirestoreUserCollectionRemote({required this.address});

  Future<QuerySnapshot?> getUserCollectionDoc() async {
    try {
      return await FirebaseFirestore.instance.collection(address).get();
    } catch (e) {
      await Analytics().logEvent(
        logName: 'Firestore user collection remote get data exeption',
        log: {'exeption': e.toString()},
      );

      return null;
    }
  }
}
