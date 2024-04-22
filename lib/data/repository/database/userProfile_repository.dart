import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trip_market/data/source/remote/database/userProfile_remote.dart';
import 'package:trip_market/data/source/local/database/sharedPreferences_local.dart';
import 'package:trip_market/model/trip_model.dart';
import 'package:trip_market/model/user_model.dart';
import 'package:trip_market/data/source/remote/database/post_remote.dart';

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

/////////////////////////////

class GetUserRecentViewTripRepository {
  final String _key = 'recentViewTrip';

  Future<List<Trip>> fromSharedPreferences() async {
    List<Trip> tripList = [];
    List<String>? jsonList =
        await LocalSharedPreferences(key: _key).getStringList();

    if (jsonList != null) {
      for (String json in jsonList) {
        Trip trip = Trip.fromJson(jsonDecode(json));
        tripList.add(trip);
      }
    }

    return tripList;
  }
}

class SetUserRecentViewTripRepository {
  final String _key = 'recentViewTrip';

  Future<void> toSharedPreferences({required List<Trip> tripList}) async {
    List<String> jsonList = [];
    for (Trip trip in tripList) {
      String json = jsonEncode(trip.toJson());
      jsonList.add(json);
    }
    await LocalSharedPreferences(key: _key).setStringList(value: jsonList);
  }
}

//////////////////////////////

class GetUserInterestRepository {
  final String _key = 'myInterest';
  Future<Map<String, dynamic>> fromSharedPreferences() async {
    Map<String, dynamic> interest = {};
    String? json = await LocalSharedPreferences(key: _key).getString();
    if (json != null) {
      interest = jsonDecode(json) as Map<String, dynamic>;
    }

    return interest;
  }
}

class SetUserInterestRepository {
  final String _key = 'myInterest';
  Future<void> toSharedPreferences(
      {required Map<String, dynamic> interest}) async {
    String json = jsonEncode(interest);
    await LocalSharedPreferences(key: _key).setString(value: json);
  }
}

/////////////////////////////

class GetFavoriteTripRepository {
  final String _key = 'favoriteTrip';

  Future<List<String>> getTripNameFromSharedPreferences() async {
    List<String>? docNameList =
        await LocalSharedPreferences(key: _key).getStringList();

    docNameList ??= [];

    return docNameList;
  }

  Future<List<Trip>> getTripFromFirestore(
      {required List<String> tripNameList}) async {
    List<Trip> tripList = [];

    for (String tripName in tripNameList) {
      await FirestorePostRemote()
          .getTripPost(field: 'docName', constraint: tripName, docCount: 1)
          .then((snapshot) {
        if (snapshot != null) {
          for (QueryDocumentSnapshot doc in snapshot.docs) {
            Map<String, dynamic> tripData = doc.data() as Map<String, dynamic>;
            if (tripData.isNotEmpty) {
              Trip thisTrip = Trip.fromJson(tripData);
              tripList.add(thisTrip);
            }
          }
        }
      });
    }

    return tripList;
  }
}

class SetFavoriteTripRepository {
  final String _key = 'favoriteTrip';

  Future<void> toSharedPreferences(
      {required List<String> favoriteTripList}) async {
    await LocalSharedPreferences(key: _key)
        .setStringList(value: favoriteTripList);
  }
}
