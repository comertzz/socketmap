import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_map/core/flavor/flavor_config.dart';
import 'package:socket_map/core/theme/theme.dart';
import 'package:socket_map/core/theme/theme_mode_provider.dart';
import 'package:socket_map/features/vehicle_tracking/presentation/screens/tracking_map_screen.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flavor = FlavorConfig.current;
    final themeMode = ref.watch(appThemeModeProvider);

    return MaterialApp(
      title: flavor.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.buildLightTheme(flavor),
      darkTheme: AppTheme.buildDarkTheme(flavor),
      themeMode: themeMode,
      home: const TrackingMapScreen(),
    );
  }
}