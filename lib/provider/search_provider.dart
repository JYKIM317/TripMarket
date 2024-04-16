import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trip_market/viewModel/home/screen/search/searchHistory_viewmodel.dart';
import 'package:trip_market/viewModel/home/screen/search/searchTrip_viewmodel.dart';

final searchHistoryProvider =
    ChangeNotifierProvider<SearchHistoryViewModel>((ref) {
  return SearchHistoryViewModel();
});

final searchTripProvider = ChangeNotifierProvider<SearchTripViewModel>((ref) {
  return SearchTripViewModel();
});
