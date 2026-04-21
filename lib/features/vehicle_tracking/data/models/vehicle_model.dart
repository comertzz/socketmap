import '../../domain/entities/vehicle_entity.dart';

class VehicleModel extends VehicleEntity {
  VehicleModel({
    required super.name,
    required super.latitude,
    required super.longitude,
    required super.speed,
    required super.timestamp,
  });

  factory VehicleModel.fromMap(Map<String, dynamic> map) {
    return VehicleModel(
   
      name: map['name'] ?? 'unknown_name',
      latitude: (map['lat'] as num).toDouble(),
      longitude: (map['lng'] as num).toDouble(),
      speed: (map['hiz'] as num).toInt(),
      timestamp: DateTime.now(), 
    );
  }
}