import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trip_market/model/trip_model.dart';
import 'package:trip_market/data/repository/database/recommend_repository.dart';

class RecommendTripViewModel extends ChangeNotifier {
  List<Trip>? _recommendTripList;

  List<Trip>? get recommendTripList => _recommendTripList;

  bool isLoading = false;

  int tripCount = 0;
  DocumentSnapshot? lastDoc;

  Map<String, dynamic> tempTag = {};
  Map<String, dynamic> tempDestination = {};
  List<String> tempSearchHistory = [];

  initialization() {
    _recommendTripList = null;
    isLoading = false;
    tripCount = 0;
    lastDoc = null;
    notifyListeners();
  }

  Future<void> getTrip({
    bool? recursion,
    Map<String, dynamic>? myInterestTag,
    Map<String, dynamic>? myInterestDestination,
    List<String>? searchHistory,
  }) async {
    recursion ??= false;

    if (!isLoading || recursion) {
      isLoading = true;
      //notifyListeners();

      if (!recursion) {
        tripCount += 30;
        myInterestTag != null ? tempTag = myInterestTag : null;
        myInterestDestination != null
            ? tempDestination = myInterestDestination
            : null;
        searchHistory != null ? tempSearchHistory = searchHistory : null;
      }

      await GetRecommendTripList()
          .fromFirestore(
        myInterestTag: myInterestTag ?? tempTag,
        myInterestDestination: myInterestDestination ?? tempDestination,
        searchHistory: searchHistory ?? tempSearchHistory,
        tripCount: tripCount,
        existingTripList: _recommendTripList,
        lastDoc: lastDoc,
      )
          .then((response) async {
        if (response.isNotEmpty) {
          _recommendTripList = response['recommendTripList'];
          bool existAnyDoc = response['existAnyDoc'];
          lastDoc = response['lastDoc'];

          //재귀
          if (_recommendTripList!.length < tripCount && existAnyDoc) {
            await getTrip(recursion: true);
          }
        }
      });

      isLoading = false;
      notifyListeners();
    }
  }
}
