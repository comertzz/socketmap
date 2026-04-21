class AppConfig {
  static const String socketUrl = String.fromEnvironment(
    'SOCKET_URL',
    defaultValue: 'http://localhost:3000',
  );

  static const String trackingDeviceName = String.fromEnvironment(
    'TRACKING_DEVICE_NAME',
    defaultValue: 'demo-device',
  );
}
