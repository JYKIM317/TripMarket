import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trip_market/data/source/remote/database/trip_remote.dart';
import 'package:trip_market/model/trip_model.dart';

class SaveTripRepository {
  Future<void> toFirestore({required Trip trip}) async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    Map<String, dynamic> json = trip.toJson();

    await FirestoreTripRemote().saveMyTripDoc(uid: userUID, json: json);
  }
}

class DeleteTripRepository {
  Future<void> toFirestore({required String docName}) async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;

    await FirestoreTripRemote().deleteMyTripDoc(uid: userUID, docName: docName);
  }
}

class GetUserTripListRepository {
  Future<List<Trip>> fromFirestore() async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    List<Trip> myTripList = [];
    await FirestoreTripRemote().getUserTripList(uid: userUID).then((snapshot) {
      if (snapshot != null) {
        for (QueryDocumentSnapshot doc in snapshot.docs) {
          Map<String, dynamic> tripJson = doc.data() as Map<String, dynamic>;
          Trip thisTrip = Trip.fromJson(tripJson);
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
