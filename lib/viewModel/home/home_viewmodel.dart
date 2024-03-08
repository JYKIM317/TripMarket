import 'package:trip_market/data/repository/database/database_repository.dart';

class HomeViewModel {
  void requestUpdateLastLoginHistory() {
    FirestoreRepository().updateUserData();
  }
}
