import 'package:flutter/material.dart';
import 'package:trip_market/data/repository/database/banner_repository.dart';

class MainBannerViewModel extends ChangeNotifier {
  List<dynamic>? _bannerList;

  List<dynamic>? get bannerList => _bannerList;

  Future<void> fetchMyBannerList() async {
    try {
      _bannerList = await GetMainBannerRepository().fromFirestore();
      notifyListeners();
    } catch (e) {
      _bannerList = [];
      notifyListeners();
    }
  }
}
