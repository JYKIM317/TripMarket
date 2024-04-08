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
  late Map<String, dynamic> planOfDay;
  late List<dynamic> tag;

  Trip({
    required this.docName,
    required this.title,
    required this.nation,
    required this.duration,
    required this.createAt,
    required this.uid,
    required this.planOfDay,
    required this.tag,
  });

  Trip.fromJson(Map<String, dynamic> json) {
    docName = json['docName'];
    title = json['title'];
    nation = json['nation'];
    duration = json['duration'];
    createAt = json['createAt'].toDate();
    uid = json['uid'];
    planOfDay = jsonDecode(json['planOfDay']);
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() => {
        'docName': docName,
        'title': title,
        'nation': nation,
        'duration': duration,
        'createAt': createAt,
        'uid': uid,
        'planOfDay': jsonEncode(planOfDay),
        'tag': tag,
      };

  Trip copyWith({
    String? docName,
    String? title,
    String? nation,
    int? duration,
    DateTime? createAt,
    String? uid,
    Map<String, dynamic>? planOfDay,
    List<dynamic>? tag,
  }) =>
      Trip(
        docName: docName ?? this.docName,
        title: title ?? this.title,
        nation: nation ?? this.nation,
        duration: duration ?? this.duration,
        createAt: createAt ?? this.createAt,
        uid: uid ?? this.uid,
        planOfDay: planOfDay ?? this.planOfDay,
        tag: tag ?? this.tag,
      );

  factory Trip.initial({required String nation}) => Trip(
        docName: 'tripPlan_${Random().nextInt(4294967296)}',
        title: '',
        nation: nation,
        duration: 1,
        createAt: DateTime.now(),
        uid: FirebaseAuth.instance.currentUser!.uid,
        planOfDay: {},
        tag: [],
      );
}
