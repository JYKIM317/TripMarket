import 'package:flutter/material.dart';
import 'package:trip_market/data/repository/database/database_repository.dart';
import 'package:trip_market/model/user_model.dart';

class UserProfileViewModel extends ChangeNotifier {
  UserProfile? _userProfile;

  UserProfile? get userProfile => _userProfile;

  Future<void> fetchUserProfile() async {
    try {
      _userProfile = await GetUserProfileRepository().fromFirestore();
      notifyListeners();
    } catch (e) {
      _userProfile = UserProfile.initial();
      notifyListeners();
    }
  }

  Future<void> updateUserProfile({required UserProfile profile}) async {
    _userProfile = profile;
    notifyListeners();
    UpdateUserProfileRepository().toFirestore(userProfile: profile);
  }
}
