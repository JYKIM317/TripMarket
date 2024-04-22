import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trip_market/data/source/local/database/sharedPreferences_local.dart';
import 'package:trip_market/data/source/remote/database/post_remote.dart';
import 'package:trip_market/model/trip_model.dart';

const String searchHistoryKey = 'searchHistory';

class GetSearchHistory {
  Future<List<String>> fromSharedPreferences() async {
    List<String> history = [];
    await LocalSharedPreferences(key: searchHistoryKey)
        .getStringList()
        .then((value) {
      if (value != null) {
        history.addAll(value);
      }
    });

    return history;
  }
}

class SetSearchHistory {
  Future<void> toSharedPreferences({required List<String> history}) async {
    await LocalSharedPreferences(key: searchHistoryKey)
        .setStringList(value: history);
  }
}

class GetSearchTripList {
  Future<Map<String, dynamic>> fromFirestore({
    required String search,
    String? nationFilter,
    int? durationFilter,
    DocumentSnapshot? lastDoc,
    List<Trip>? existingTripList,
    required int tripCount,
  }) async {
    bool existSearch = search != '';
    Map<String, dynamic> response = {};
    int getDocCount = 50;
    List<Trip> tripPostList = existingTripList ?? [];

    await FirestorePostRemote()
        .getSearchTripPostList(
      nation: nationFilter,
      duration: durationFilter,
      lastDocument: lastDoc,
      getDocCount: getDocCount,
    )
        .then((snapshot) {
      if (snapshot != null) {
        for (QueryDocumentSnapshot doc in snapshot.docs) {
          if (doc.id == snapshot.docs.last.id) {
            response.addAll({'lastDoc': doc});

            if (snapshot.docs.length == getDocCount) {
              response.addAll({'existAnyDoc': true});
            } else {
              response.addAll({'existAnyDoc': false});
            }
          }
          //search
          Map<String, dynamic>? tripPost = doc.data() as Map<String, dynamic>?;

          if (tripPost != null) {
            if (existSearch) {
              String thisTripTitle = tripPost['title'];
              List<dynamic> thisTripTag = tripPost['tag'];
              if (thisTripTitle.contains(search) ||
                  thisTripTag.contains(search)) {
                Trip thisTrip = Trip.fromJson(tripPost);
                tripPostList.add(thisTrip);
              }
            } else {
              Trip thisTrip = Trip.fromJson(tripPost);
              tripPostList.add(thisTrip);
            }
          }
        }
        response.addAll({'searchTripList': tripPostList});
      }
    });

    return response;
  }
}
