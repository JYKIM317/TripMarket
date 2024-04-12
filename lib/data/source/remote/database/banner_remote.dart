import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trip_market/data/source/remote/database/firestore/firestore_banner_remote.dart';

class FirestoreBannerRemote {
  Future<DocumentSnapshot?> getMainBanner() async {
    const String address = 'main';

    return await FirestoreBannerDocumentRemote(address: address)
        .getBannerDocumentData();
  }
}
