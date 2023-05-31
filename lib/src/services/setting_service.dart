// Package imports:
import 'package:hive/hive.dart';

// Project imports:
import 'package:farmtrack/src/constants/constants.dart';

class SettingService {
  final _settingBox = Hive.box(Constants.darkModeBox);

  dynamic read() {
    try {
      return _settingBox.get(Constants.darkModeBox, defaultValue: false);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> updateItem(dynamic value) async {
    try {
      await _settingBox.put(Constants.darkModeBox, value);
    } catch (error) {
      throw Exception(error);
    }
  }
}
