import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_map/features/vehicle_tracking/data/sources/mock_vehicle_data.dart';
import '../models/vehicle_model.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger();

class TrackingRemoteDataSource {
  final IO.Socket _socket;
  StreamSubscription? _mockSubscription;

  TrackingRemoteDataSource(this._socket);

  Stream<List<VehicleModel>> getFleetStream() {
    final controller = StreamController<List<VehicleModel>>();

    _socket.on('filo_verisi_akisi', (data) {
      if (!controller.isClosed) {
        try {
          _stopMockStream();
          final List<dynamic> fleetList = data as List<dynamic>;

          final fleetModels = fleetList.map((item) {
            return VehicleModel.fromMap(Map<String, dynamic>.from(item));
          }).toList();

          controller.add(fleetModels);
        } catch (e) {
          logger.e("Filo verisi dönüştürme hatası: $e");
        }
      }
    });

    _socket.onDisconnect((_) {
      if (!controller.isClosed) {
        logger.i("Soket bağlantısı kesildi, veri akışı durdu.");
        logger.i("Mock verilere geçiliyor.");
        _startMockStream(controller);
      
      _socket.onReconnect(  (_) {
        _socket.emit('takip_baslat');
        logger.i("Soket yeniden bağlandı, gerçek verilere geçiliyor.");
      }
      );
      }
    });

    return controller.stream;
  }
  void _startMockStream(StreamController<List<VehicleModel>> controller) {
    _mockSubscription?.cancel(); // Eski varsa temizle
    _mockSubscription = MockVehicleService.getMockFleetStream().listen((mockFleet) {
      if (!controller.isClosed) {
        controller.add(mockFleet);
      }
    });
  }
  void _stopMockStream() {
    if (_mockSubscription != null) {
      logger.i("Gerçek veri akışı başladı, Mock susturuldu.");
      _mockSubscription?.cancel();
      _mockSubscription = null;
    }
  }

}

