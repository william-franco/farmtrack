// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:farmtrack/src/dependency_injector/dependency_injector.dart';
import 'package:farmtrack/src/features/settings/view_models/setting_view_model.dart';
import 'package:farmtrack/src/routes/routes.dart';
import 'package:farmtrack/src/services/storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService().initStorage();

  runApp(
    const DependencyInjector(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<SettingViewModel>().value;
    return MaterialApp(
      title: 'FarmTrack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      routes: RoutesNew.routes,
      initialRoute: RoutesNew.farms,
    );
  }
}
