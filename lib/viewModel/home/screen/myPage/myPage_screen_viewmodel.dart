import 'package:trip_market/data/repository/database/database_repository.dart';

class MyPageScreenViewModel {
  Future<Map<String, dynamic>> requestGetUserData() async {
    return await FirestoreRepository().getUserData();
  }
}
