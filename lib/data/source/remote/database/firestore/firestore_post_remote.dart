import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trip_market/analytics.dart';

const String collectionName = 'post';

class FirestorePostDocumentRemote {
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
  CollectionReference collection =
      FirebaseFirestore.instance.collection(collectionName);

  Future<QuerySnapshot?> getPostNoConstraintCollectionDoc({
    DocumentSnapshot? lastDocument,
    required int getDocCount,
  }) async {
    if (lastDocument == null) {
      try {
        return await collection.limit(getDocCount).get();
      } catch (e) {
        await Analytics().logEvent(
          logName:
              'Firestore post collection remote get no constraint data exeption',
          log: {'exeption': e.toString()},
        );

        return null;
      }
    } else {
      try {
        return await collection
            .startAfterDocument(lastDocument)
            .limit(getDocCount)
            .get();
      } catch (e) {
        await Analytics().logEvent(
          logName:
              'Firestore post collection remote get no constraint data exeption',
          log: {'exeption': e.toString()},
        );

        return null;
      }
    }
  }

  Future<QuerySnapshot?> getPostWithConstraintCollectionDoc<T>({
    DocumentSnapshot? lastDocument,
    String? firstField,
    String? secondField,
    T? firstFilter,
    T? secondFilter,
    required int getDocCount,
  }) async {
    bool existFirstFilter = firstField != null && firstFilter != null;
    bool existSecondFilter = secondField != null && secondFilter != null;
    bool isTwoFilter = existFirstFilter && existSecondFilter;

    if (lastDocument == null) {
      if (isTwoFilter) {
        try {
          return await collection
              .where(firstField, isEqualTo: firstFilter)
              .where(secondField, isEqualTo: secondFilter)
              .limit(getDocCount)
              .get();
        } catch (e) {
          await Analytics().logEvent(
            logName:
                'Firestore post collection remote get two constraint data exeption',
            log: {'exeption': e.toString()},
          );

          return null;
        }
      } else {
        try {
          return await collection
              .where(firstField!, isEqualTo: firstFilter)
              .limit(getDocCount)
              .get();
        } catch (e) {
          await Analytics().logEvent(
            logName:
                'Firestore post collection remote get one constraint data exeption',
            log: {'exeption': e.toString()},
          );

          return null;
        }
      }
    } else {
      if (isTwoFilter) {
        try {
          return await collection
              .startAfterDocument(lastDocument)
              .where(firstField, isEqualTo: firstFilter)
              .where(secondField, isEqualTo: secondFilter)
              .limit(getDocCount)
              .get();
        } catch (e) {
          await Analytics().logEvent(
            logName:
                'Firestore post collection remote get two constraint data exeption',
            log: {'exeption': e.toString()},
          );

          return null;
        }
      } else {
        try {
          return await collection
              .startAfterDocument(lastDocument)
              .where(firstField!, isEqualTo: firstFilter)
              .limit(getDocCount)
              .get();
        } catch (e) {
          await Analytics().logEvent(
            logName:
                'Firestore post collection remote get one constraint data exeption',
            log: {'exeption': e.toString()},
          );

          return null;
        }
      }
    }
  }
}
