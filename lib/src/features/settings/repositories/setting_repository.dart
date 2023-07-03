// Dart imports:
import 'dart:developer';

// Project imports:
import 'package:farmtrack/src/services/setting_service.dart';

class SettingRepository {
  final SettingService settingService;

  SettingRepository({
    required this.settingService,
  });

  bool readTheme() {
    try {
      return settingService.read();
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> updateThemeAt(bool isDarkTheme) async {
    try {
      await settingService.updateItem(isDarkTheme);
      log('Theme updated in box with value $isDarkTheme');
    } catch (error) {
      throw Exception(error);
    }
  }
}
