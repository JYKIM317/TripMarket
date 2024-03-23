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

  addMyTripList({required Trip trip}) {
    _tripList ?? [];
    _tripList!.add(trip);
    notifyListeners();
  }
}
