import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_map/app.dart';
import 'package:socket_map/core/flavor/app_flavor.dart';
import 'package:socket_map/core/flavor/flavor_config.dart';

void main() {
  FlavorConfig.current = FlavorConfig.forFlavor(AppFlavor.takibiz);

  runApp(
    const ProviderScope(
      child: MyApp(),
      
    ),
  );
}
