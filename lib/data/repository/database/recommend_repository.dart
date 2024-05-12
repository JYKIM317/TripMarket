import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trip_market/data/source/remote/database/post_remote.dart';
import 'package:trip_market/model/trip_model.dart';

class GetRecommendTripList {
  Future<Map<String, dynamic>> fromFirestore({
    required Map<String, dynamic> myInterestTag,
    required Map<String, dynamic> myInterestDestination,
    required List<String> searchHistory,
    DocumentSnapshot? lastDoc,
    List<Trip>? existingTripList,
    required int tripCount,
  }) async {
    int getDocCount = tripCount * 2;
    List<Trip> tripPostList = existingTripList ?? [];
    Map<String, dynamic> response = {};

    List<Trip> tempList = [];

    List<dynamic> tagList = myInterestTag.keys.toList();
    List<dynamic> destinationList = myInterestDestination.keys.toList();

    await FirestorePostRemote()
        .getTripPostList(
      lastDoc: lastDoc,
      docCount: getDocCount,
    )
        .then((snapshot) {
      if (snapshot != null) {
        for (QueryDocumentSnapshot doc in snapshot.docs) {
          Map<String, dynamic>? tripPost = doc.data() as Map<String, dynamic>?;

          if (tripPost != null) {
            bool interestDestination =
                destinationList.contains(tripPost['nation']);
            bool interestTag = tagList
                .contains((element) => tripPost['tag'].contains(element));
            bool interestSearch = false;
            for (String search in searchHistory) {
              //
              if (tripPost['title'].contains(search)) {
                interestSearch = true;
                break;
              } else if (tripPost['tag']
                  .contains((tagElement) => tagElement.contains(search))) {
                interestSearch = true;
              } else {
                interestSearch = false;
              }
            }
            print('dd');

            if (interestDestination || interestTag || interestSearch) {
              Trip thisTrip = Trip.fromJson(tripPost);
              tripPostList.add(thisTrip);
            } else {
              Trip thisTrip = Trip.fromJson(tripPost);
              tempList.add(thisTrip);
            }
          }

          if (doc.id == snapshot.docs.last.id) {
            response.addAll({'lastDoc': doc});

            if (snapshot.docs.length == getDocCount) {
              response.addAll({'existAnyDoc': true});
            } else {
              response.addAll({'existAnyDoc': false});
              if (snapshot.docs.length != getDocCount) {
                for (int i = 0;
                    tripPostList.length < tripCount && i + 1 < tempList.length;
                    i++) {
                  tripPostList.add(tempList[i]);
                }
              }
            }
          }
        }

        response.addAll({'recommendTripList': tripPostList});
      }
    });

    return response;
  }
}
