import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trip_market/model/user_model.dart';
import 'package:trip_market/provider/myPage_provider.dart';
import 'package:trip_market/viewModel/home/screen/myPage/editMyProfile/editMyProfile_viewmodel.dart';

class EditMyProfileWidgets {
  Widget profileImage() {
    return Consumer(
      builder: (context, ref, child) {
        UserProfile profile = ref.watch(profileProvider).userProfile!;
        return Column(
          children: [
            Text(
              AppLocalizations.of(context)!.profileImage,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Hero(
              tag: 'profile',
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
                clipBehavior: Clip.hardEdge,
                child: profile.profileImage != null
                    ? Image.memory(
                        base64Decode(profile.profileImage!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            )
          ],
        );
      },
    );
  }

  Widget nation() {
    return Consumer(
      builder: (context, ref, child) {
        UserProfile profile = ref.watch(profileProvider).userProfile!;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.nation,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black54,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Text(
                  profile.nation!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class EditMyProfileName extends ConsumerStatefulWidget {
  const EditMyProfileName({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditMyProfileNameState();
}

class _EditMyProfileNameState extends ConsumerState<EditMyProfileName> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserProfile profile = ref.watch(profileProvider).userProfile!;
    nameController.text = profile.name!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
          profile.name = text;
          EditMyProfileViewModel()
              .requestUpdateProfileName(profile: profile, ref: ref);
        },
      ),
    );
  }
}
