import 'package:flutter/material.dart';
import 'package:trip_market/model/trip_model.dart';
import 'package:trip_market/data/repository/database/userProfile_repository.dart';

class RecentViewTripViewModel extends ChangeNotifier {
  List<Trip>? _recentViewTripList;
  List<Trip>? get recentViewTripList => _recentViewTripList;

  List<String>? _recentViewTripNameList;
  List<String>? get recentViewTripNameList => _recentViewTripNameList;

  Future<void> fetchMyRecentViewTrip() async {
    _recentViewTripList =
        await GetUserRecentViewTripRepository().fromSharedPreferences();
    for (Trip thisTrip in _recentViewTripList!) {
      _recentViewTripNameList ??= [];
      _recentViewTripNameList!.add(thisTrip.docName);
    }
    notifyListeners();
  }

  Future<void> updateMyRecentView({required Trip trip}) async {
    _recentViewTripNameList ??= [];
    if (!_recentViewTripNameList!.contains(trip.docName)) {
      _recentViewTripList!.insert(0, trip);
      _recentViewTripNameList!.insert(0, trip.docName);
      if (_recentViewTripList!.length > 10) {
        _recentViewTripList!.removeLast();
        _recentViewTripNameList!.removeLast();
      }
    } else {
      int index = _recentViewTripNameList!.indexOf(trip.docName);
      _recentViewTripList!.removeAt(index);
      _recentViewTripList!.insert(0, trip);
      _recentViewTripNameList!.removeAt(index);
      _recentViewTripNameList!.insert(0, trip.docName);
    }
    notifyListeners();
    await SetUserRecentViewTripRepository()
        .toSharedPreferences(tripList: _recentViewTripList!);
  }
}
