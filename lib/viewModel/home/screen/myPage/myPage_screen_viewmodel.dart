import 'package:flutter/material.dart';
import 'package:trip_market/data/repository/database/database_repository.dart';
import 'package:trip_market/model/user_model.dart';

class MyPageScreenViewModel extends ChangeNotifier {
  UserProfile? _userProfile;
  //FirestoreRepository firestoreRepository;

  //MyPageScreenViewModel(this.firestoreRepository);

  UserProfile? get userProfile => _userProfile;

  Future<void> fetchUserProfile() async {
    try {
      _userProfile = await FirestoreRepository().getUserProfile();
      notifyListeners();
    } catch (e) {
      _userProfile = UserProfile.initial();
    }
  }
}
