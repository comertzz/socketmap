import 'dart:async';

import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:socket_map/core/config/app_config.dart';
import 'package:socket_map/features/vehicle_tracking/data/sources/mock_vehicle_data.dart';

import '../models/vehicle_model.dart';

final Logger logger = Logger();

class TrackingRemoteDataSource {
  TrackingRemoteDataSource(this._socket);

  final io.Socket _socket;
  StreamSubscription? _mockSubscription;
  bool _listenersAttached = false;

  Stream<List<VehicleModel>> getFleetStream() {
    final controller = StreamController<List<VehicleModel>>();

    _attachSocketListeners(controller);

    if (_socket.connected) {
      _emitTrackingStart();
    } else {
      _socket.connect();
    }

    controller.onCancel = () async {
      await _mockSubscription?.cancel();
      _mockSubscription = null;
      _socket.off('connect');
      _socket.off('connect_error');
      _socket.off('error');
      _socket.off('disconnect');
      _socket.off('reconnect');
      _socket.off('filo_verisi_akisi');
      _listenersAttached = false;
    };

    return controller.stream;
  }

  void _attachSocketListeners(StreamController<List<VehicleModel>> controller) {
    if (_listenersAttached) {
      return;
    }

    _listenersAttached = true;

    _socket.onConnect((_) {
      logger.i('Socket connected: ${_socket.id} -> ${_socket.io.uri}');
      _emitTrackingStart();
    });

    _socket.onConnectError((error) {
      logger.e('Socket connect error: $error');
      if (!controller.isClosed) {
        _startMockStream(controller);
      }
    });

    _socket.onError((error) {
      logger.e('Socket error: $error');
    });

    _socket.onDisconnect((_) {
      logger.i('Socket disconnected, switching to mock data.');
      if (!controller.isClosed) {
        _startMockStream(controller);
      }
    });

    _socket.onReconnect((_) {
      logger.i('Socket reconnected, restarting tracking.');
      _emitTrackingStart();
    });

    _socket.on('filo_verisi_akisi', (data) {
      if (controller.isClosed) {
        return;
      }

      try {
        final fleetList = data as List<dynamic>;
        final fleetModels = fleetList
            .map((item) => VehicleModel.fromMap(Map<String, dynamic>.from(item)))
            .toList();

        _stopMockStream();
        controller.add(fleetModels);
      } catch (e) {
        logger.e('Fleet payload parse error: $e');
      }
    });
  }

  void _emitTrackingStart() {
    logger.i(
      'Emitting takip_baslat to ${AppConfig.socketUrl} for ${AppConfig.trackingDeviceName}',
    );
    _socket.emit('takip_baslat', {
      'cihaz_adi': AppConfig.trackingDeviceName,
    });
  }

  void _startMockStream(StreamController<List<VehicleModel>> controller) {
    _mockSubscription?.cancel();
    _mockSubscription = MockVehicleService.getMockFleetStream().listen((
      mockFleet,
    ) {
      if (!controller.isClosed) {
        controller.add(mockFleet);
      }
    });
  }

  void _stopMockStream() {
    if (_mockSubscription == null) {
      return;
    }

    logger.i('Real socket data received, stopping mock stream.');
    _mockSubscription?.cancel();
    _mockSubscription = null;
  }
}
