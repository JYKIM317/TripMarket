import 'package:flutter/material.dart';
import 'package:trip_market/data/repository/database/database_repository.dart';
import 'package:trip_market/model/trip_model.dart';

class MyTripListViewModel extends ChangeNotifier {
  List<Trip>? _tripList;

  List<Trip>? get tripList => _tripList;

  Future<void> fetchMyTripList() async {
    try {
      _tripList = await GetUserTripListRepository().fromFirestore();
      notifyListeners();
    } catch (e) {
      _tripList = [];
    }
  }

  Future<void> addMyTripList({
    required Trip trip,
    bool? modify,
  }) async {
    _tripList ?? [];
    modify ?? false;
    if (!modify!) {
      _tripList!.insert(0, trip);
      notifyListeners();
    }
  }

  Future<void> removeAtMyTripList({required Trip trip}) async {
    String docName = trip.docName;
    _tripList!.remove(trip);
    notifyListeners();

    DeleteTripRepository().toFirestore(docName: docName);
  }
}
