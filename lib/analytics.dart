import 'package:firebase_analytics/firebase_analytics.dart';

class Analytics {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> logEvent({
    required String logName,
    required Map<String, dynamic> log,
  }) async {
    await analytics.logEvent(
      name: logName,
      parameters: log,
    );
  }
}
