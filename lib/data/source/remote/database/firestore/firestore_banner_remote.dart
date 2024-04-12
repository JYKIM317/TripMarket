import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trip_market/analytics.dart';

class FirestoreBannerDocumentRemote {
  final String collectionName = 'banner';
  late String address;

  FirestoreBannerDocumentRemote({required this.address});

  Future<DocumentSnapshot?> getBannerDocumentData() async {
    try {
      return await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(address)
          .get();
    } catch (e) {
      await Analytics().logEvent(
        logName: 'Firestore banner doc remote get data exeption',
        log: {'exeption': e.toString()},
      );

      return null;
    }
  }
}
