import 'package:flutter/material.dart';
import 'package:trip_market/data/repository/database/search_repository.dart';

class SearchHistoryViewModel extends ChangeNotifier {
  List<String>? _searchHistory;

  List<String>? get searchHistory => _searchHistory;

  Future<void> fetchMySearchHistory() async {
    try {
      _searchHistory = await GetSearchHistory().fromSharedPreferences();
    } catch (e) {
      _searchHistory = [];
    }
    notifyListeners();
  }

  Future<void> addMySearchHistory({required String element}) async {
    _searchHistory ??= [];
    if (_searchHistory!.contains(element)) {
      _searchHistory!.remove(element);
      _searchHistory!.insert(0, element);
    } else {
      _searchHistory!.insert(0, element);
      if (_searchHistory!.length > 10) {
        _searchHistory!.removeAt(10);
      }
    }
    notifyListeners();
    await SetSearchHistory().toSharedPreferences(history: _searchHistory!);
  }

  Future<void> removeMySearchHistory({required int index}) async {
    _searchHistory!.removeAt(index);
    notifyListeners();
    await SetSearchHistory().toSharedPreferences(history: _searchHistory!);
  }
}
