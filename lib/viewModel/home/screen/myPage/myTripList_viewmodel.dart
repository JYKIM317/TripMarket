import 'package:flutter/material.dart';
import 'package:trip_market/data/repository/database/trip_repository.dart';
import 'package:trip_market/model/trip_model.dart';

class MyTripListViewModel extends ChangeNotifier {
  List<Trip>? _tripList;
  List<Trip>? get tripList => _tripList;

  List<String>? _tripDocNameList;
  List<String>? get tripDocNameList => _tripDocNameList;

  Future<void> fetchMyTripList() async {
    try {
      _tripList = await GetUserTripListRepository().fromFirestore();
      if (_tripList!.isNotEmpty) {
        for (Trip thisTrip in _tripList!) {
          _tripDocNameList ??= [];
          _tripDocNameList!.add(thisTrip.docName);
        }
      }
    } catch (e) {
      _tripList = [];
      _tripDocNameList = [];
    }
    notifyListeners();
  }

  Future<void> addMyTripList({
    required Trip trip,
    bool? modify,
  }) async {
    _tripList ??= [];
    modify ??= false;
    if (!modify) {
      _tripList!.insert(0, trip);
      _tripDocNameList!.insert(0, trip.docName);
      notifyListeners();
    }
    await SaveTripRepository().toFirestore(trip: trip);
  }

  Future<void> removeAtMyTripList({required Trip trip}) async {
    String docName = trip.docName;
    _tripList!.remove(trip);
    notifyListeners();

    DeleteTripRepository().toFirestore(docName: docName);
  }
}
