import 'package:firebase_auth/firebase_auth.dart';
import 'package:trip_market/data/source/remote/database/database_remote.dart';
import 'package:trip_market/model/user_model.dart';

class FirestoreRepository {
  Future<UserProfile> getUserProfile() async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;

    return await FirestoreRemote().getUserProfileFromFirestore(uid: userUID);
  }

  Future<void> updateLastLoginHistory() async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    DateTime now = DateTime.now();
    Map<String, dynamic> data = {
      'lastLogin': now,
      'uid': userUID,
    };

    try {
      await FirestoreRemote().updateLastLogin(data: data);
    } catch (e) {
      const String noDocError =
          '[cloud_firestore/not-found] Some requested document was not found.';
      if (e.toString() == noDocError) {
        Map<String, dynamic> json = UserProfile(
          name: 'user_${userUID.substring(1, 5)}',
          nation: '',
          uid: userUID,
          profileImage: null,
        ).toJson();

        FirestoreRemote().setUserProfileToFirestore(json: json);
      }
    }
  }

  Future<void> updateUserProfile({required UserProfile userProfile}) async {
    Map<String, dynamic> json = userProfile.toJson();

    await FirestoreRemote().updateUserProfileToFirestore(json: json);
  }
}
