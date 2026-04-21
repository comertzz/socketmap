import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:socket_map/features/vehicle_tracking/data/sources/tracking_remote_data_source.dart';
import 'package:socket_map/features/vehicle_tracking/domain/entities/vehicle_entity.dart';

const String _socketUrl = String.fromEnvironment(
  'SOCKET_URL',
  defaultValue: 'http://localhost:3000',
);

const String _deviceName = String.fromEnvironment(
  'TRACKING_DEVICE_NAME',
  defaultValue: 'demo-device',
);

final socketProvider = Provider<io.Socket>((ref) {
  return io.io(
    _socketUrl,
    io.OptionBuilder().setTransports(['websocket']).build(),
  );
});

final trackingDataSourceProvider = Provider((ref) {
  final socket = ref.watch(socketProvider);
  return TrackingRemoteDataSource(socket);
});

final vehicleTrackingViewModelProvider =
    StreamProvider<List<VehicleEntity>>((ref) {
      final dataSource = ref.watch(trackingDataSourceProvider);

      ref.read(socketProvider).emit('takip_baslat', {'cihaz_adi': _deviceName});

      return dataSource.getFleetStream();
    });
