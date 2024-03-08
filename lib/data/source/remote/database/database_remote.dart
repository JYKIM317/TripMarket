import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRemote {
  Future<void> updateUserDataToFirestore({
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    final firestoreAddress =
        FirebaseFirestore.instance.collection('user').doc(uid);

    await firestoreAddress.update(data);
  }

  Future<void> setUserDataToFirestore({
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    final firestoreAddress =
        FirebaseFirestore.instance.collection('user').doc(uid);

    await firestoreAddress.set(data);
  }

  Future<DocumentSnapshot> getUserDataFromFirestore(
      {required String uid}) async {
    final firestoreAddress =
        FirebaseFirestore.instance.collection('user').doc(uid);

    return await firestoreAddress.get();
  }
}
