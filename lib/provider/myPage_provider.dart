import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trip_market/data/repository/database/database_repository.dart';
import 'package:trip_market/viewModel/home/screen/myPage/myPage_screen_viewmodel.dart';

final firestoreRepositoryProvider = Provider((ref) => FirestoreRepository());

final profileProvider = ChangeNotifierProvider<UserProfileViewModel>((ref) {
  return UserProfileViewModel(ref.watch(firestoreRepositoryProvider));
});
//

final newTripDuration =
    StateNotifierProvider<NewTripDurationNotifier, int?>((ref) {
  return NewTripDurationNotifier();
});

class NewTripDurationNotifier extends StateNotifier<int?> {
  NewTripDurationNotifier() : super(1);

  update(int? duration) {
    state = duration;
  }
}

final planOfDaysIndex =
    StateNotifierProvider<PlanOfDaysIndexNotifier, int?>((ref) {
  return PlanOfDaysIndexNotifier();
});

class PlanOfDaysIndexNotifier extends StateNotifier<int?> {
  PlanOfDaysIndexNotifier() : super(0);

  update(int? index) {
    state = index;
  }
}

final planOfDayData =
    StateNotifierProvider<PlanOfDayDataNotifier, Map<String, List<dynamic>>?>(
        (ref) {
  return PlanOfDayDataNotifier();
});

class PlanOfDayDataNotifier extends StateNotifier<Map<String, List<dynamic>>?> {
  PlanOfDayDataNotifier() : super({});

  update(Map<String, List<dynamic>>? data) {
    if (data == null) {
      state = data;
    } else {
      state ??= {};
      state!.addAll(data);
    }
  }
}

//List<Map<String, dynamic>>
