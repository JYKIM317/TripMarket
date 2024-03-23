import 'package:flutter/material.dart';
import 'package:trip_market/data/repository/database/database_repository.dart';
import 'package:trip_market/model/user_model.dart';

class UserProfileViewModel extends ChangeNotifier {
  FirestoreRepository repository;
  UserProfile? _userProfile;

  UserProfile? get userProfile => _userProfile;

  UserProfileViewModel(this.repository);

  Future<void> fetchUserProfile() async {
    try {
      _userProfile = await repository.getUserProfile();
      notifyListeners();
    } catch (e) {
      _userProfile = UserProfile.initial();
    }
  }

  Future<void> updateUserProfile({required UserProfile profile}) async {
    try {
      _userProfile = profile;
      notifyListeners();
      await repository.updateUserProfile(userProfile: profile);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
