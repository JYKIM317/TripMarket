import 'package:firebase_auth/firebase_auth.dart';
import 'package:trip_market/data/source/remote/database/database_remote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepository {
  Future<void> updateLastLoginHistory() async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    DateTime now = DateTime.now();
    Map<String, dynamic> data = {'lastLogin': now};
    try {
      FirestoreRemote().updateUserDataToFirestore(uid: userUID, data: data);
    } catch (e) {
      const String noDocError =
          '[cloud_firestore/not-found] Some requested document was not found.';
      if (e.toString() == noDocError) {
        Map<String, dynamic> firstData = {
          'name': 'user_${userUID.substring(1, 5)}',
          'nation': '',
          'uid': userUID,
          'lastLogin': now,
        };
        FirestoreRemote().setUserDataToFirestore(uid: userUID, data: firstData);
      }
    }
  }

  Future<void> updateUserData() async {
    //String userUID = FirebaseAuth.instance.currentUser!.uid;
  }

  Future<void> setUserData() async {
    //String userUID = FirebaseAuth.instance.currentUser!.uid;
  }

  Future<Map<String, dynamic>> getUserData() async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot document =
        await FirestoreRemote().getUserDataFromFirestore(uid: userUID);
    Map<String, dynamic>? userData = document.data() as Map<String, dynamic>?;

    userData ??= {
      'name': 'user_${userUID.substring(1, 5)}',
      'nation': '',
      'uid': userUID,
    };

    return userData;
  }
}
