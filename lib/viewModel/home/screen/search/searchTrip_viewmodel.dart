import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trip_market/model/trip_model.dart';
import 'package:trip_market/data/repository/database/search_repository.dart';

class SearchTripViewModel extends ChangeNotifier {
  List<Trip>? _searchTripList;

  List<Trip>? get searchTripList => _searchTripList;

  bool isLoading = false;

  int tripCount = 0;
  DocumentSnapshot? lastDoc;

  String? nationFilter;
  int? durationFilter;

  searchInitialization() {
    _searchTripList = null;
    isLoading = false;
    tripCount = 0;
    lastDoc = null;
    notifyListeners();
  }

  filterInitialization() {
    nationFilter = null;
    durationFilter = null;
    notifyListeners();
  }

  setNationFilter({required String nation}) {
    nationFilter = nation;
    notifyListeners();
  }

  setDurationFilter({required int duration}) {
    durationFilter = duration;
    notifyListeners();
  }

  Future<void> searchTrip({required String search}) async {
    isLoading = true;
    notifyListeners();
    tripCount += 30;

    await GetSearchTripList()
        .fromFirestore(
      search: search,
      tripCount: tripCount,
      nationFilter: nationFilter,
      durationFilter: durationFilter,
      existingTripList: _searchTripList,
      lastDoc: lastDoc,
    )
        .then((response) {
      if (response.isNotEmpty) {
        _searchTripList = response['searchTripList'];
        bool existAnyDoc = response['existAnyDoc'];
        lastDoc = response['lastDoc'];

        //재귀
        if (_searchTripList!.length < tripCount && existAnyDoc) {
          tripCount -= 30;
          searchTrip(search: search);
        }
      }
    });

    isLoading = false;
    notifyListeners();
  }

  //trip count랑 > searchTripList length인데 existMoreDoc : true 면 재귀함수
}
