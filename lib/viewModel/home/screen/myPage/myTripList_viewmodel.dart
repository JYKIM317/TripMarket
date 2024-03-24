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

  Future<void> addMyTripList({required Trip trip}) async {
    _tripList ?? [];
    _tripList!.add(trip);
    notifyListeners();
    try {
      await FirestoreRepository().saveTrip(trip: trip);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
