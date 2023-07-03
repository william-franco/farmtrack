// Dart imports:
import 'dart:io';

// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

// Project imports:
import 'package:farmtrack/src/constants/constants.dart';
import 'package:farmtrack/src/features/settings/repositories/setting_repository.dart';
import 'package:farmtrack/src/features/settings/view_models/setting_view_model.dart';
import 'package:farmtrack/src/services/setting_service.dart';

void main() {
  group('Test SettingViewModel class', () {
    late SettingService settingService;
    late SettingRepository settingRepository;
    late SettingViewModel settingViewModel;

    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();

      // Directory used for store temporary the boxes
      const directoryPath = '/build/';

      final appDir = await Directory.current.createTemp(directoryPath);

      // Initializes the hive and points it to the temporary storage location
      Hive.init(appDir.path);

      await Hive.openBox(Constants.darkModeBox);

      settingService = SettingService();
      settingRepository = SettingRepository(
        settingService: settingService,
      );
      settingViewModel = SettingViewModel(
        settingRepository: settingRepository,
      );
    });

    test('Test initial value', () {
      expect(settingViewModel.value, equals(false));
    });

    test('Test method update an value', () async {
      await settingViewModel.update(true);
      expect(settingViewModel.value, equals(true));
    });
  });
}
