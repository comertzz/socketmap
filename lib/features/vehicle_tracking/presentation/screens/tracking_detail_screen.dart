import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:socket_map/core/flavor/flavor_config.dart';
import 'package:socket_map/features/vehicle_tracking/presentation/providers/tracking_providers.dart';

class TrackingDetailScreen extends ConsumerStatefulWidget {
  const TrackingDetailScreen({super.key, required this.vehicleName});

  final String vehicleName;

  @override
  ConsumerState<TrackingDetailScreen> createState() =>
      _TrackingDetailScreenState();
}

class _TrackingDetailScreenState extends ConsumerState<TrackingDetailScreen> {
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final fleetAsync = ref.watch(vehicleTrackingViewModelProvider);
    final flavor = FlavorConfig.current;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('${flavor.appTitle} | ${widget.vehicleName} Detayi'),
      ),
      body: fleetAsync.when(
        data: (fleet) {
          final vehicle = fleet.firstWhere(
            (v) => v.name == widget.vehicleName,
            orElse: () => throw Exception('Arac bulunamadi'),
          );

          WidgetsBinding.instance.addPostFrameCallback((_) {
            _mapController.move(
              LatLng(vehicle.latitude, vehicle.longitude),
              15.0,
            );
          });

          return Column(
            children: [
              Flexible(
                flex: 2,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: LatLng(
                        vehicle.latitude,
                        vehicle.longitude,
                      ),
                      initialZoom: 15.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.socket_map',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(vehicle.latitude, vehicle.longitude),
                            width: 60,
                            height: 60,
                            child: SizedBox(
                              width: 30,
                              height: 38.77,
                              child: SvgPicture.asset(
                                'assets/svg/moving_state.svg',
                                clipBehavior: Clip.antiAlias,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.speed,
                                size: 30,
                                color: colorScheme.primary,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '${vehicle.speed} km/h',
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineMedium,
                              ),
                            ],
                          ),
                          const Divider(),
                          _buildDetailRow(
                            context,
                            Icons.pin_drop,
                            'Konum',
                            '${vehicle.latitude.toStringAsFixed(4)}, ${vehicle.longitude.toStringAsFixed(4)}',
                          ),
                          _buildDetailRow(
                            context,
                            Icons.power_settings_new,
                            'Kontak',
                            'Acik (Simulasyon)',
                          ),
                          ElevatedButton.icon(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back),
                            label: const Text('Listeye Don'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        error: (err, stack) => Center(child: Text('Hata: $err')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    IconData icon,
    String title,
    String value,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(icon, color: colorScheme.secondary),
        const SizedBox(width: 10),
        Text(
          '$title:',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Text(value),
      ],
    );
  }
}
