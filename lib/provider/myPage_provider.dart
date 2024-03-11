import 'package:flutter_riverpod/flutter_riverpod.dart';

final profile =
    StateNotifierProvider<ProfileNameNotifier, Map<String, dynamic>?>((ref) {
  return ProfileNameNotifier();
});

class ProfileNameNotifier extends StateNotifier<Map<String, dynamic>?> {
  ProfileNameNotifier() : super({});

  update(Map<String, dynamic>? profile) {
    if (profile == null) {
      state = profile;
    } else {
      state ??= {};
      state!.addAll(profile);
    }
  }
}
