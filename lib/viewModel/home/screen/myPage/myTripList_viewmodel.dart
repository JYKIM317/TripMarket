import 'package:flutter/material.dart';
import 'package:trip_market/data/repository/database/database_repository.dart';
import 'package:trip_market/model/trip_model.dart';

class MyTripListViewModel extends ChangeNotifier {
  FirestoreRepository repository;
  List<Trip>? _tripList;

  List<Trip>? get tripList => _tripList;

  MyTripListViewModel(this.repository);

  Future<void> fetchMyTripList() async {
    try {
      _tripList = await repository.getUserTrip();
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

    try {
      await FirestoreRepository().saveTrip(trip: trip);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> removeAtMyTripList({required Trip trip}) async {
    String docName = trip.docName;
    _tripList!.remove(trip);
    notifyListeners();
    try {
      await FirestoreRepository().removeTrip(docName: docName);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
