import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:trip_market/CustomIcon.dart';
import 'package:trip_market/viewModel/settings/settings_viewmodel.dart';
import 'package:trip_market/main.dart';

class SettingsPageWidgets {
  Widget accountButton(context) {
    return InkWell(
      onTap: () {
        //Navigator Account Setting Page
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            const Icon(
              CustomIcon.user,
              color: Colors.grey,
              size: 21,
            ),
            const SizedBox(width: 16),
            Text(
              AppLocalizations.of(context)!.account,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget languageButton(context) {
    return InkWell(
      onTap: () {
        //Navigator Language Setting Page
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            const Icon(
              CustomIcon.language_1,
              color: Colors.grey,
              size: 21,
            ),
            const SizedBox(width: 16),
            Text(
              AppLocalizations.of(context)!.language,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget helpButton(context) {
    return InkWell(
      onTap: () {
        //Navigator Help Support Page
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            const Icon(
              CustomIcon.help_circled,
              color: Colors.grey,
              size: 21,
            ),
            const SizedBox(width: 16),
            Text(
              AppLocalizations.of(context)!.help,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget signOutButton(context) {
    return InkWell(
      onTap: () async {
        //Sign Out ViewModel
        await SettingsViewModel().requestSignOut().then(
          (_) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => RoutePage(),
              ),
              (route) => false,
            );
          },
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            const Icon(
              CustomIcon.logout,
              color: Colors.red,
              size: 21,
            ),
            const SizedBox(width: 16),
            Text(
              AppLocalizations.of(context)!.signOut,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
