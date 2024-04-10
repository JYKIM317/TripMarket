import 'package:firebase_auth/firebase_auth.dart';
import 'package:trip_market/data/source/remote/database/post_remote.dart';
import 'package:trip_market/model/trip_model.dart';

class GetUserPostedTripListRepository {
  Future<List<dynamic>> fromFirestore() async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    List<dynamic> postedDocNameList = [];
    await FirestorePostRemote()
        .getUserPostedTrip(uid: userUID)
        .then((snapshot) {
      Map<String, dynamic>? docData = snapshot?.data() as Map<String, dynamic>?;
      if (docData != null) {
        List<dynamic> docList = docData['docList'] ?? [];
        postedDocNameList.addAll(docList);
      }
    });

    return postedDocNameList;
  }
}

class SetUserPostedTripListRepository {
  Future<void> toFirestore({required List<dynamic> postList}) async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    Map<String, dynamic> json = {'docList': postList};

    await FirestorePostRemote().setUserPostedTrip(uid: userUID, json: json);
  }
}

class SetTripPostRepository {
  Future<void> toFirestore({required Trip trip}) async {
    Map<String, dynamic> json = trip.toJson();

    await FirestorePostRemote().setTripPost(json: json);
  }
}

class DeleteTripPostRepository {
  Future<void> toFirestore({required String docName}) async {
    await FirestorePostRemote().deleteTripPost(docName: docName);
  }
}
