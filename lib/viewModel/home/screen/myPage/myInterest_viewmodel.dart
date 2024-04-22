import 'package:flutter/material.dart';
import 'package:trip_market/data/repository/database/userProfile_repository.dart';

class MyInterestViewModel extends ChangeNotifier {
  Map<String, dynamic>? _myInterestTag;
  Map<String, dynamic>? get myInterestTag => _myInterestTag;

  Map<String, dynamic>? _myInterestDestination;
  Map<String, dynamic>? get myInterestDestination => _myInterestDestination;

  Future<void> fetchMyInterest() async {
    _myInterestTag =
        await GetUserInterestRepository().tagFromSharedPreferences();
    _myInterestDestination =
        await GetUserInterestRepository().destinationFromSharedPreferences();
    notifyListeners();
  }

  Future<void> updateMyInterestTag({required List<dynamic> tagList}) async {
    for (final tag in tagList) {
      _myInterestTag ??= {};
      bool exist = _myInterestTag!.containsKey(tag);
      if (exist) {
        _myInterestTag![tag]++;
      } else {
        _myInterestTag!.addAll({tag: 1});
      }
    }
    notifyListeners();
    await SetUserInterestRepository()
        .tagToSharedPreferences(interest: _myInterestTag!);
  }

  Future<void> updateMyInterestDestination(
      {required String destination}) async {
    _myInterestDestination ??= {};
    bool exist = _myInterestDestination!.containsKey(destination);
    if (exist) {
      _myInterestDestination![destination]++;
    } else {
      _myInterestDestination!.addAll({destination: 1});
    }

    notifyListeners();
    await SetUserInterestRepository()
        .destinationToSharedPreferences(interest: _myInterestDestination!);
  }
}
