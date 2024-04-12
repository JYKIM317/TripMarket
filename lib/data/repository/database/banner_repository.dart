import 'package:trip_market/data/source/remote/database/banner_remote.dart';

class GetMainBannerRepository {
  Future<List<dynamic>> fromFirestore() async {
    List<dynamic> bannerUrlList = [];
    await FirestoreBannerRemote().getMainBanner().then((snapshot) {
      Map<String, dynamic>? docData = snapshot?.data() as Map<String, dynamic>?;
      if (docData != null) {
        List<dynamic> imageList = docData['image'] ?? [];
        bannerUrlList.addAll(imageList);
      }
    });

    return bannerUrlList;
  }
}
