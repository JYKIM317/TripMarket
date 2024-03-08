import 'package:trip_market/data/repository/auth/auth_repository.dart';

class SettingsViewModel {
  Future<void> requestSignOut() async {
    await FirebaseAuthRepository().signOutAuth();
  }
}
