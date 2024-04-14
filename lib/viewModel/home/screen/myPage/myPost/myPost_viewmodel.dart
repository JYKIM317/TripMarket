import 'package:flutter/material.dart';
import 'package:trip_market/data/repository/database/post_repository.dart';
import 'package:trip_market/model/trip_model.dart';

class MyPostViewModel extends ChangeNotifier {
  List<dynamic>? _postList;

  List<dynamic>? get postList => _postList;

  Future<void> fetchMyPostList() async {
    try {
      _postList = await GetUserPostedTripListRepository().fromFirestore();
    } catch (e) {
      _postList = [];
    }
    notifyListeners();
  }

  Future<void> shareMyTrip({required Trip trip}) async {
    String docName = trip.docName;
    _postList ??= [];
    _postList!.add(docName);
    notifyListeners();

    await SetTripPostRepository().toFirestore(trip: trip).then((_) async {
      await SetUserPostedTripListRepository().toFirestore(postList: postList!);
    });
  }

  Future<void> deleteSharedMyTrip({required Trip trip}) async {
    String docName = trip.docName;
    bool removeState = postList!.remove(docName);
    notifyListeners();

    if (removeState) {
      await DeleteTripPostRepository()
          .toFirestore(docName: docName)
          .then((_) async {
        await SetUserPostedTripListRepository()
            .toFirestore(postList: postList!);
      });
    }
  }
}
