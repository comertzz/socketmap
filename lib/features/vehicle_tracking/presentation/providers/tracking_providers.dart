import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:socket_map/core/config/app_config.dart';
import 'package:socket_map/features/vehicle_tracking/data/sources/tracking_remote_data_source.dart';
import 'package:socket_map/features/vehicle_tracking/domain/entities/vehicle_entity.dart';

final socketProvider = Provider<io.Socket>((ref) {
  final socket = io.io(
    AppConfig.socketUrl,
    io.OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .build(),
  );

  ref.onDispose(socket.dispose);

  return socket;
});

final trackingDataSourceProvider = Provider((ref) {
  final socket = ref.watch(socketProvider);
  return TrackingRemoteDataSource(socket);
});

final vehicleTrackingViewModelProvider =
    StreamProvider<List<VehicleEntity>>((ref) {
      final dataSource = ref.watch(trackingDataSourceProvider);
      final socket = ref.watch(socketProvider);

      if (!socket.connected) {
        socket.connect();
      }

      return dataSource.getFleetStream();
    });
