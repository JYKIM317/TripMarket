import 'package:firebase_auth/firebase_auth.dart';

class UserProfile {
  String? name;
  String? nation;
  String? profileImage;
  String? uid;

  UserProfile({this.name, this.nation, this.profileImage, this.uid});

  UserProfile.fromJson(Map<String, dynamic> json) {
    name = json['name'] ??
        'user_${FirebaseAuth.instance.currentUser!.uid.substring(1, 5)}';
    nation = json['nation'] ?? '';
    profileImage = json['profileImage'];
    uid = json['uid'] ?? FirebaseAuth.instance.currentUser!.uid;
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'nation': nation,
        'profileImage': profileImage,
        'uid': uid,
      };

  factory UserProfile.initial() {
    return UserProfile(
      name: 'user_${FirebaseAuth.instance.currentUser!.uid.substring(1, 5)}',
      nation: '',
      profileImage: null,
      uid: FirebaseAuth.instance.currentUser!.uid,
    );
  }
}
