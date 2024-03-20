import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';
import 'dart:convert';

class Trip {
  late String docName;
  late String title;
  late String nation;
  late int duration;
  late DateTime createAt;
  late String uid;
  late Map<String, List<dynamic>> planOfDay;

  Trip({
    required this.docName,
    required this.title,
    required this.nation,
    required this.duration,
    required this.createAt,
    required this.uid,
    required this.planOfDay,
  });

  Trip.fromJson(Map<String, dynamic> json) {
    docName = json['docName'];
    title = json['title'];
    nation = json['nation'];
    duration = json['duration'];
    createAt = json['createAt'];
    uid = json['uid'];
    planOfDay = jsonDecode(json['planOfDay']);
  }

  Map<String, dynamic> toJson() => {
        'docName': docName,
        'title': title,
        'nation': nation,
        'duration': duration,
        'createAt': createAt,
        'uid': uid,
        'planOfDay': jsonEncode(planOfDay),
      };

  factory Trip.initial({required String nation}) {
    return Trip(
      docName: 'tripPlan_${Random().nextInt(4294967296)}',
      title: '',
      nation: nation,
      duration: 1,
      createAt: DateTime.now(),
      uid: FirebaseAuth.instance.currentUser!.uid,
      planOfDay: {},
    );
  }
}
