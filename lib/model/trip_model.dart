import 'package:firebase_auth/firebase_auth.dart';

class Trip {
  late String title;
  late String nation;
  late int duration;
  late DateTime createAt;
  late String uid;
  late List<dynamic> planOfDay;

  Trip({
    required this.title,
    required this.nation,
    required this.duration,
    required this.createAt,
    required this.uid,
    required this.planOfDay,
  });

  Trip.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    nation = json['nation'];
    duration = json['duration'];
    createAt = json['createAt'];
    uid = json['uid'];
    planOfDay = json['planOfDay'];
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'nation': nation,
        'duration': duration,
        'createAt': createAt,
        'uid': uid,
        'planOfDay': planOfDay,
      };

  factory Trip.initial({required String nation}) {
    return Trip(
      title: '',
      nation: nation,
      duration: 1,
      createAt: DateTime.now(),
      uid: FirebaseAuth.instance.currentUser!.uid,
      planOfDay: [],
    );
  }
}
