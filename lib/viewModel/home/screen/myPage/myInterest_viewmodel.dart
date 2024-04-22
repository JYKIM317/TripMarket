import 'package:flutter/material.dart';
import 'package:trip_market/data/repository/database/userProfile_repository.dart';

class MyInterestViewModel extends ChangeNotifier {
  Map<String, dynamic>? _myInterest;

  Map<String, dynamic>? get myInterest => _myInterest;

  Future<void> fetchMyInterest() async {
    _myInterest = await GetUserInterestRepository().fromSharedPreferences();
    notifyListeners();
  }

  Future<void> updateMyInterest({required List<dynamic> tagList}) async {
    for (final tag in tagList) {
      _myInterest ??= {};
      bool exist = _myInterest!.containsKey(tag);
      if (exist) {
        _myInterest![tag]++;
      } else {
        _myInterest!.addAll({tag: 1});
      }
    }
    notifyListeners();
    await SetUserInterestRepository()
        .toSharedPreferences(interest: _myInterest!);
  }
}
