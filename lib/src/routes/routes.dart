// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:farmtrack/src/features/farms/views/edit_farm_view.dart';
import 'package:farmtrack/src/features/farms/views/farm_view.dart';
import 'package:farmtrack/src/features/settings/views/setting_view.dart';

class RoutesNew {
  static const String home = '/';
  static const String farms = '/farms';
  static const String farmEdit = '/farm-edit';
  static const String settings = '/settings';

  static final routes = <String, WidgetBuilder>{
    farms: (BuildContext context) => const FarmView(),
    farmEdit: (BuildContext context) => const EditFarmView(),
    settings: (BuildContext context) => const SettingView(),
  };
}
