import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditMyProfileWidgets {
  Widget profileImage({
    required BuildContext context,
    required String? currentProfileImage,
  }) {
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
        Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.hardEdge,
          child: currentProfileImage != null
              ? Image.memory(
                  base64Decode(currentProfileImage),
                  fit: BoxFit.cover,
                )
              : null,
        )
        /*
        CircleAvatar(
          radius: MediaQuery.of(context).size.width / 4,
          backgroundColor: Colors.grey,
          foregroundImage: Image.memory(base64Decode(currentProfileImage)),
        ),
        */
      ],
    );
  }

  Widget nation({
    required BuildContext context,
    required String currentNation,
  }) {
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Text(
              currentNation,
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
  }
}
