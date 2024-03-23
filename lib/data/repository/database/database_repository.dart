import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trip_market/data/source/remote/database/database_remote.dart';
import 'package:trip_market/model/user_model.dart';
import 'package:trip_market/model/trip_model.dart';

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

  Future<void> saveTrip({required Trip trip}) async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    Map<String, dynamic> json = trip.toJson();

    await FirestoreRemote().saveTripToFirestore(uid: userUID, json: json);
  }

  Future<List<Trip>> getUserTrip() async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    List<Trip> myTripList = [];
    await FirestoreRemote()
        .getMyTripFromFirestore(uid: userUID)
        .then((snapshot) {
      if (snapshot != null) {
        for (QueryDocumentSnapshot doc in snapshot.docs) {
          Map<String, dynamic> docData = doc.data() as Map<String, dynamic>;
          Trip thisTrip = Trip.fromJson(docData);
          myTripList.add(thisTrip);
        }

        //sort by descending
        if (myTripList.isNotEmpty) {
          myTripList.sort((a, b) => b.createAt.compareTo(a.createAt));
        }
      }
    });

    return myTripList;
  }
}
