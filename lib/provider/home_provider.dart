import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trip_market/viewModel/home/home_viewmodel.dart';
import 'package:trip_market/viewModel/home/screen/home/mainBanner_viewmodel.dart';
import 'package:trip_market/viewModel/home/screen/home/recommendTrip_viewmodel.dart';

final homeProvider = StateNotifierProvider<HomeViewModel, int?>((ref) {
  return HomeViewModel();
});

final bannerProvider = ChangeNotifierProvider<MainBannerViewModel>((ref) {
  return MainBannerViewModel();
});

final recommendProvider = ChangeNotifierProvider<RecommendTripViewModel>((ref) {
  return RecommendTripViewModel();
});
