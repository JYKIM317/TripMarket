import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trip_market/viewModel/home/screen/myPage/favoriteTrip_viewmodel.dart';
import 'package:trip_market/viewModel/home/screen/myPage/userProfile_viewmodel.dart';
import 'package:trip_market/viewModel/trip/trip_viewmodel.dart';
import 'package:trip_market/viewModel/home/screen/myPage/myTripList_viewmodel.dart';
import 'package:trip_market/viewModel/home/screen/myPage/myPost/myPost_viewmodel.dart';
import 'package:trip_market/viewModel/home/screen/myPage/recentViewTrip_viewmodel.dart';
import 'package:trip_market/viewModel/home/screen/myPage/myInterest_viewmodel.dart';

final profileProvider = ChangeNotifierProvider<UserProfileViewModel>((ref) {
  return UserProfileViewModel();
});
//

final tripProvider = ChangeNotifierProvider<TripViewModel>((ref) {
  return TripViewModel();
});
//

final myTripListProvider = ChangeNotifierProvider<MyTripListViewModel>((ref) {
  return MyTripListViewModel();
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

final postProvider = ChangeNotifierProvider<MyPostViewModel>((ref) {
  return MyPostViewModel();
});

final recentViewProvider =
    ChangeNotifierProvider<RecentViewTripViewModel>((ref) {
  return RecentViewTripViewModel();
});

final myInterestProvider = ChangeNotifierProvider<MyInterestViewModel>((ref) {
  return MyInterestViewModel();
});

final favoriteProvider = ChangeNotifierProvider<FavoriteTripViewModel>((ref) {
  return FavoriteTripViewModel();
});
