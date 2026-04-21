import 'dart:math';
import '../models/vehicle_model.dart';

class MockVehicleService {
  static final List<Map<String, dynamic>> _baseVehicles = [
    {"name": "23 ELZ 23", "lat": 38.67, "lng": 39.22, "angle": Random().nextDouble() * 360},
    {"name": "34 IST 34", "lat": 41.00, "lng": 28.97, "angle": Random().nextDouble() * 360},
    {"name": "06 ANK 06", "lat": 39.93, "lng": 32.85, "angle": Random().nextDouble() * 360},
    {"name": "35 IZM 35", "lat": 38.42, "lng": 27.14, "angle": Random().nextDouble() * 360},
    {"name": "07 ANT 07", "lat": 36.88, "lng": 30.70, "angle": Random().nextDouble() * 360},
    {"name": "61 TRB 61", "lat": 41.00, "lng": 39.71, "angle": Random().nextDouble() * 360},
    {"name": "16 BUR 16", "lat": 40.18, "lng": 29.06, "angle": Random().nextDouble() * 360},
    {"name": "21 DIY 21", "lat": 37.91, "lng": 40.21, "angle": Random().nextDouble() * 360},
  ];

  static Stream<List<VehicleModel>> getMockFleetStream() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 3));

      yield _baseVehicles.map((arac) {
        const double stepSize = 0.0015;
        double angleRad = arac["angle"] * (3.14159 / 180.0);
        
        arac["lat"] = (arac["lat"] as double) + (cos(angleRad) * stepSize);
        arac["lng"] = (arac["lng"] as double) + (sin(angleRad) * stepSize);

        if (Random().nextDouble() > 0.95) {
          arac["angle"] = (arac["angle"] as double) + (Random().nextDouble() - 0.5) * 20;
        }

        return VehicleModel(
          name: arac["name"],
          latitude: arac["lat"],
          longitude: arac["lng"],
          speed: Random().nextInt(40) + 60,
          timestamp: DateTime.now(),
        );
      }).toList();
    }
  }
}