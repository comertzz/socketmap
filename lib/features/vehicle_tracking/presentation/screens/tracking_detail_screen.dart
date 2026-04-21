import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import '../providers/tracking_providers.dart';

class TrackingDetailScreen extends ConsumerStatefulWidget {
  final String vehicleName;
  const TrackingDetailScreen({super.key, required this.vehicleName});

  @override
  ConsumerState<TrackingDetailScreen> createState() =>
      _TrackingDetailScreenState();
}

class _TrackingDetailScreenState extends ConsumerState<TrackingDetailScreen> {
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final fleetAsync = ref.watch(vehicleTrackingViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: Text("${widget.vehicleName} Detayı")),
      body: fleetAsync.when(
        data: (fleet) {
          final vehicle = fleet.firstWhere(
            (v) => v.name == widget.vehicleName,
            orElse: () => throw Exception("Araç bulunamadı"),
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
                                clipBehavior: Clip.antiAlias,
                                'assets/svg/moving_state.svg',
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
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.speed,
                                size: 30,
                                color: Colors.orange,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "${vehicle.speed.toInt()} km/h",
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineMedium,
                              ),
                            ],
                          ),
                          const Divider(),
                          _buildDetailRow(
                            Icons.pin_drop,
                            "Konum",
                            "${vehicle.latitude.toStringAsFixed(4)}, ${vehicle.longitude.toStringAsFixed(4)}",
                          ),
                          _buildDetailRow(
                            Icons.power_settings_new,
                            "Kontak",
                            "Açık (Simülasyon)",
                          ),
                          ElevatedButton.icon(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back),
                            label: const Text("Listeye Dön"),
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
        error: (err, stack) => Center(child: Text("Hata: $err")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueGrey),
        const SizedBox(width: 10),
        Text("$title:", style: const TextStyle(fontWeight: FontWeight.bold)),
        const Spacer(),
        Text(value),
      ],
    );
  }
}
