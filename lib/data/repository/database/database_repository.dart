import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trip_market/data/source/remote/database/database_remote.dart';
import 'package:trip_market/model/user_model.dart';
import 'package:trip_market/model/trip_model.dart';

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

class GetUserPostedTripListRepository {
  Future<List<String>> fromFirestore() async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    List<String> postedDocNameList = [];
    await FirestorePostRemote()
        .getUserPostedTrip(uid: userUID)
        .then((snapshot) {
      Map<String, dynamic>? docData = snapshot?.data() as Map<String, dynamic>?;
      if (docData != null) {
        List<String> docList = docData['docList'] ?? [];
        postedDocNameList.addAll(docList);
      }
    });

    return postedDocNameList;
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
