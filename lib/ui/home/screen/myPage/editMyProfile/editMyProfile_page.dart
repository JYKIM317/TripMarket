import 'package:geolocator/geolocator.dart';
import 'package:trip_market/model/user_model.dart';
import 'package:trip_market/provider/myPage_provider.dart';
import 'package:trip_market/ui/home/screen/myPage/editMyProfile/editMyProfile_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trip_market/viewModel/home/screen/myPage/editMyProfile/editMyProfile_viewmodel.dart';

class EditMyProfilePage extends ConsumerWidget {
  const EditMyProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserProfile profile = ref.watch(profileProvider).userProfile!;
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
                  onTap: () {
                    EditMyProfileViewModel()
                        .requestUpdateProfileImage(profile: profile, ref: ref);
                  },
                  child: EditMyProfileWidgets().profileImage(),
                ),
                const SizedBox(height: 20),
                //Name
                EditMyProfileName(),
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
                        EditMyProfileViewModel().requestUpdateProfileNation(
                            profile: profile, ref: ref);
                      } else {
                        //permission is undetermine or denied
                        permission = await Geolocator.requestPermission();
                      }
                    });
                  },
                  child: EditMyProfileWidgets().nation(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
