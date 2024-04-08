import 'package:flutter/material.dart';
import 'package:trip_market/data/repository/database/database_repository.dart';

class MyPostViewModel extends ChangeNotifier {
  FirestoreRepository repository;
  List<String>? _postList;

  List<String>? get postList => _postList;

  MyPostViewModel(this.repository);

  Future<void> fetchMyPostList() async {
    try {
      _postList = await repository.getMyPostedTripDocNameList();
      notifyListeners();
    } catch (e) {
      _postList = [];
      notifyListeners();
    }
  }
}
