import 'package:geolocator/geolocator.dart';
import 'package:trip_market/provider/myPage_provider.dart';
import 'package:trip_market/ui/home/screen/myPage/editMyProfile/editMyProfile_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trip_market/viewModel/home/screen/myPage/editMyProfile/editMyProfile_viewmodel.dart';

class EditMyProfilePage extends ConsumerStatefulWidget {
  final userData;
  const EditMyProfilePage({super.key, required this.userData});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditMyProfilePageState();
}

class _EditMyProfilePageState extends ConsumerState<EditMyProfilePage> {
  TextEditingController nameController = TextEditingController();
  late String name, uid, nation;
  String? profileImage;
  late Map<String, dynamic> userData;

  @override
  void initState() {
    userData = widget.userData;
    name = userData['name'];
    nameController.text = name;
    nation = userData['nation'];
    profileImage = userData['profileImage'];
    uid = userData['uid'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
          ),
          titleSpacing: 0,
          title: Text(
            AppLocalizations.of(context)!.editProfile,
            style: const TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.only(top: 44, bottom: 34),
            child: Column(
              children: [
                //Profile image
                InkWell(
                  onTap: () async {
                    await EditMyProfileViewModel()
                        .requestUpdateProfileImage()
                        .then(
                      (value) {
                        if (value != null) {
                          ref.read(profile.notifier).update(null);
                          profileImage = value;
                          ref.read(profile.notifier).update({
                            'name': name,
                            'nation': nation,
                            'profileImage': profileImage,
                            'uid': uid,
                          });
                        }
                      },
                    );
                  },
                  child: EditMyProfileWidgets().profileImage(
                    context: context,
                    currentProfileImage: ref.watch(profile)!['profileImage'],
                  ),
                ),
                const SizedBox(height: 20),
                //Name
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: TextField(
                    controller: nameController,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.name,
                      labelStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                    minLines: 1,
                    maxLines: 1,
                    onSubmitted: (text) {
                      name = text;
                      EditMyProfileViewModel()
                          .requestUpdateProfileName(name: name);
                      ref.read(profile.notifier).update(null);
                      ref.read(profile.notifier).update({
                        'name': name,
                        'nation': nation,
                        'profileImage': profileImage,
                        'uid': uid,
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                //Nation
                InkWell(
                  onTap: () async {
                    await EditMyProfileViewModel()
                        .locationPermissionCheck()
                        .then((permission) async {
                      //permission is grant
                      if (permission == LocationPermission.whileInUse ||
                          permission == LocationPermission.always) {
                        await EditMyProfileViewModel()
                            .requestUpdateProfileNation()
                            .then((result) {
                          if (result != '') {
                            ref.read(profile.notifier).update(null);
                            nation = result;
                            ref.read(profile.notifier).update({
                              'name': name,
                              'nation': nation,
                              'profileImage': profileImage,
                              'uid': uid,
                            });
                          }
                        });
                      } else {
                        //permission is undetermine or denied
                        permission = await Geolocator.requestPermission();
                      }
                    });
                  },
                  child: EditMyProfileWidgets().nation(
                    context: context,
                    currentNation: ref.watch(profile)!['nation'],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
