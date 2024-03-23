import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trip_market/data/repository/database/database_repository.dart';
import 'package:trip_market/viewModel/home/screen/myPage/userProfile_viewmodel.dart';
import 'package:trip_market/viewModel/trip/trip_viewmodel.dart';
import 'package:trip_market/viewModel/home/screen/myPage/myTripList_viewmodel.dart';

final firestoreRepositoryProvider = Provider((ref) => FirestoreRepository());

final profileProvider = ChangeNotifierProvider<UserProfileViewModel>((ref) {
  return UserProfileViewModel(ref.watch(firestoreRepositoryProvider));
});
//

final tripProvider = ChangeNotifierProvider<TripViewModel>((ref) {
  return TripViewModel(ref.watch(firestoreRepositoryProvider));
});
//

final myTripListProvider = ChangeNotifierProvider<MyTripListViewModel>((ref) {
  return MyTripListViewModel(ref.watch(firestoreRepositoryProvider));
});

final planOfDaysIndex =
    StateNotifierProvider<PlanOfDaysIndexNotifier, int?>((ref) {
  return PlanOfDaysIndexNotifier();
});

class PlanOfDaysIndexNotifier extends StateNotifier<int?> {
  PlanOfDaysIndexNotifier() : super(0);

  selectIndex(int index) {
    state = index;
  }
}
