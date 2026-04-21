import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/vehicle_entity.dart';
import '../providers/tracking_providers.dart';


final vehicleTrackingViewModelProvider = StreamProvider.autoDispose<List<VehicleEntity>>((ref) {
  final dataSource = ref.watch(trackingDataSourceProvider);
  final socket = ref.watch(socketProvider);

  if (!socket.connected) {
    socket.connect();
  }

  // Takip isteğini gönder
  socket.emit('takip_baslat');

  return dataSource.getFleetStream();
});