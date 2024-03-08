import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_market/ui/settings/settings_page_widgets.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
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
          AppLocalizations.of(context)!.settings,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              SettingsPageWidgets().accountButton(context),
              const SizedBox(height: 10),
              SettingsPageWidgets().languageButton(context),
              const SizedBox(height: 10),
              SettingsPageWidgets().helpButton(context),
              const SizedBox(height: 30),
              SettingsPageWidgets().signOutButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
