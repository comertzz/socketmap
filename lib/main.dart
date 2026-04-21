import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/vehicle_tracking/presentation/screens/tracking_map_screen.dart';
import 'core/theme/theme.dart' as theme;

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Araç Takip',
      debugShowCheckedModeBanner: false,
      theme: theme.AppTheme.lightTheme,
      home: const TrackingMapScreen(),
    );
  }
}