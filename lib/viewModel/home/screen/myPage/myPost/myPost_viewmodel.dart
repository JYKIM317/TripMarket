import 'package:flutter/material.dart';
import 'package:trip_market/data/repository/database/database_repository.dart';

class MyPostViewModel extends ChangeNotifier {
  List<String>? _postList;

  List<String>? get postList => _postList;

  Future<void> fetchMyPostList() async {
    try {
      _postList = await GetUserPostedTripListRepository().fromFirestore();
      notifyListeners();
    } catch (e) {
      _postList = [];
      notifyListeners();
    }
  }
}
