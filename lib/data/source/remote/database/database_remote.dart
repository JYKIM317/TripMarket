import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trip_market/model/user_model.dart';

class FirestoreRemote {
  Future<UserProfile> getUserProfileFromFirestore({required String uid}) async {
    final firestoreAddress =
        FirebaseFirestore.instance.collection('user').doc(uid);
    DocumentSnapshot doc = await firestoreAddress.get();
    Map<String, dynamic> jsonData = doc.data() as Map<String, dynamic>;

    return UserProfile.fromJson(jsonData);
  }

  Future<void> updateUserProfileToFirestore({
    required Map<String, dynamic> json,
  }) async {
    DocumentReference firestoreAddress =
        FirebaseFirestore.instance.collection('user').doc(json['uid']);

    await firestoreAddress.update(json);
  }

  Future<void> setUserProfileToFirestore({
    required Map<String, dynamic> json,
  }) async {
    DocumentReference firestoreAddress =
        FirebaseFirestore.instance.collection('user').doc(json['uid']);

    await firestoreAddress.set(json);
  }

  Future<void> updateLastLogin({required Map<String, dynamic> data}) async {
    DocumentReference firestoreAddress =
        FirebaseFirestore.instance.collection('user').doc(data['uid']);

    await firestoreAddress.update(data);
  }
}
