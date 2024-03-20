import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trip_market/viewModel/home/home_viewmodel.dart';

final homeProvider = StateNotifierProvider<HomeViewModel, int?>((ref) {
  return HomeViewModel();
});
