// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:farmtrack/src/features/settings/repositories/setting_repository.dart';

class SettingViewModel extends ValueNotifier<bool> {
  final SettingRepository settingRepository;

  SettingViewModel({
    required this.settingRepository,
  }) : super(settingRepository.readTheme());

  Future<void> update(bool isDarkMode) async {
    value = isDarkMode;
    await settingRepository.updateThemeAt(isDarkMode);
    notifyListeners();
  }
}
