import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trip_market/data/repository/database/userProfile_repository.dart';

class HomeViewModel extends StateNotifier<int?> {
  HomeViewModel() : super(0);

  selectIndex(int index) {
    state = index;
  }

  requestUpdateLastLoginHistory() {
    UpdateLoginHistoryRepository().toFirestore();
  }
}
