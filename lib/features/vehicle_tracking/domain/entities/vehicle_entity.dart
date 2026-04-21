class VehicleEntity {
  String name;
  double latitude;
  double longitude;
  int speed;
  final DateTime timestamp;

  VehicleEntity({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.speed,
    required this.timestamp,
  });
}
