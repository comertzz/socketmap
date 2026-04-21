import 'package:flutter/material.dart';
import 'package:socket_map/core/flavor/app_flavor.dart';

class FlavorConfig {
  FlavorConfig({
    required this.flavor,
    required this.appTitle,
    required this.brandTitle,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
  });

  final AppFlavor flavor;
  final String appTitle;
  final String brandTitle;
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;

  static late FlavorConfig current;

  static FlavorConfig forFlavor(AppFlavor flavor) {
    switch (flavor) {
      case AppFlavor.takibiz:
        return FlavorConfig(
          flavor: flavor,
          appTitle: 'Takibiz',
          brandTitle: 'Filo Takibi',
          primaryColor: const Color(0xFF1FC314),
          secondaryColor: const Color(0xFF1B5E20),
          accentColor: const Color(0xFF8BC34A),
        );
      case AppFlavor.bmw:
        return FlavorConfig(
          flavor: flavor,
          appTitle: 'BMW',
          brandTitle: 'BMW Filo Takibi',
          primaryColor: const Color(0xFF1565C0),
          secondaryColor: const Color(0xFF0D47A1),
          accentColor: const Color(0xFF42A5F5),
        );
    }
  }
}
