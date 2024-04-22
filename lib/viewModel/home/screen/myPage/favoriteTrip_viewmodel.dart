import 'package:flutter/material.dart';
import 'package:trip_market/data/repository/database/userProfile_repository.dart';
import 'package:trip_market/model/trip_model.dart';

class FavoriteTripViewModel extends ChangeNotifier {
  List<Trip>? _favoriteTripList;
  List<Trip>? get favoriteTripList => _favoriteTripList;

  List<String>? _favoriteTripNameList;
  List<String>? get favoriteTripNameList => _favoriteTripNameList;

  Future<void> fetchMyFavoriteDocName() async {
    _favoriteTripNameList =
        await GetFavoriteTripRepository().getTripNameFromSharedPreferences();
    notifyListeners();
  }

  Future<void> fetchMyFavoriteTrip() async {
    _favoriteTripNameList ??=
        await GetFavoriteTripRepository().getTripNameFromSharedPreferences();
    _favoriteTripList = await GetFavoriteTripRepository()
        .getTripFromFirestore(tripNameList: _favoriteTripNameList!);
    notifyListeners();
  }

  Future<void> addMyFavoriteTrip({required String docName}) async {
    _favoriteTripNameList ??= [];
    _favoriteTripNameList!.insert(0, docName);
    _favoriteTripList = null;
    notifyListeners();
    await SetFavoriteTripRepository()
        .toSharedPreferences(favoriteTripList: _favoriteTripNameList!);
  }

  Future<void> removeMyFavoriteTrip({required String docName}) async {
    _favoriteTripNameList!.remove(docName);
    _favoriteTripList = null;
    notifyListeners();
    await SetFavoriteTripRepository()
        .toSharedPreferences(favoriteTripList: _favoriteTripNameList!);
  }
}
