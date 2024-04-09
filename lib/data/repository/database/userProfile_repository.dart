import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trip_market/data/source/remote/database/userProfile_remote.dart';
import 'package:trip_market/model/user_model.dart';

class GetUserProfileRepository {
  Future<UserProfile> fromFirestore() async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot? snapshot =
        await FirestoreUserProfileRemote().getUserProfileDoc(uid: userUID);

    if (snapshot != null) {
      Map<String, dynamic> jsonData = snapshot.data() as Map<String, dynamic>;

      return UserProfile.fromJson(jsonData);
    } else {
      return UserProfile.initial();
    }
  }
}

class UpdateUserProfileRepository {
  Future<void> toFirestore({required UserProfile userProfile}) async {
    Map<String, dynamic> json = userProfile.toJson();

    await FirestoreUserProfileRemote().updateUserProfileDoc(json: json);
  }
}

class UpdateLoginHistoryRepository {
  Future<void> toFirestore() async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    DateTime now = DateTime.now();
    Map<String, dynamic> history = {
      'lastLogin': now,
      'uid': userUID,
    };

    try {
      await FirestoreLoginHistoryRemote()
          .updateUserLastLoginHistory(json: history);
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

        await FirestoreUserProfileRemote().setUserProfileDoc(json: json);
      }
    }
  }
}
