// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:farmtrack/src/features/farms/repositories/farm_repository.dart';
import 'package:farmtrack/src/features/farms/view_models/farm_view_model.dart';
import 'package:farmtrack/src/features/settings/repositories/setting_repository.dart';
import 'package:farmtrack/src/features/settings/view_models/setting_view_model.dart';
import 'package:farmtrack/src/services/farm_service.dart';
import 'package:farmtrack/src/services/setting_service.dart';

class DependencyInjector extends StatelessWidget {
  final Widget child;

  const DependencyInjector({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Services
        Provider(
          create: (context) => FarmService(),
        ),
        Provider(
          create: (context) => SettingService(),
        ),
        // Repositories
        Provider(
          create: (context) => FarmRepository(
            farmService: context.read<FarmService>(),
          ),
        ),
        Provider(
          create: (context) => SettingRepository(
            settingService: context.read<SettingService>(),
          ),
        ),
        // ViewModels
        ChangeNotifierProvider(
          create: (context) => FarmViewModel(
            farmRepository: context.read<FarmRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingViewModel(
            settingRepository: context.read<SettingRepository>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
