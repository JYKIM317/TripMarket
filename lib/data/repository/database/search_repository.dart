import 'package:trip_market/data/source/local/database/sharedPreferences_remote.dart';

const String key = 'searchHistory';

class GetSearchHistory {
  Future<List<String>> fromSharedPreferences() async {
    List<String> history = [];
    await LocalSharedPreferences(key: key).getStringList().then((value) {
      if (value != null) {
        history.addAll(value);
      }
    });

    return history;
  }
}

class SetSearchHistory {
  Future<void> toSharedPreferences({required List<String> history}) async {
    await LocalSharedPreferences(key: key).setStringList(value: history);
  }
}
