import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:socket_map/features/vehicle_tracking/presentation/screens/tracking_detail_screen.dart';
import '../providers/tracking_providers.dart';

class TrackingMapScreen extends ConsumerStatefulWidget {
  const TrackingMapScreen({super.key});

  @override
  ConsumerState<TrackingMapScreen> createState() => _TrackingMapScreenState();
}

class _TrackingMapScreenState extends ConsumerState<TrackingMapScreen> {
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final fleetAsync = ref.watch(vehicleTrackingViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Canlı Filo Takibi"), centerTitle: true),
      body: fleetAsync.when(
        data: (fleet) {
          return FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: const LatLng(38.67, 39.22),
              initialZoom: 6.5,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.socket_map',
              ),
              MarkerLayer(
                markers: fleet.map((vehicle) {
                  return Marker(
                    point: LatLng(vehicle.latitude, vehicle.longitude),
                    width: 70,
                    height: 70,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TrackingDetailScreen(
                                vehicleName: vehicle.name,
                              ), 
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              vehicle.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          width: 40,
                          height: 48.77,
                          child: SvgPicture.asset(
                            clipBehavior: Clip.antiAlias,
                            'assets/svg/moving_state.svg',
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        }, 
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Hata: $err")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mapController.move(const LatLng(40.5, 34), 5.2);
        },
        child: const Icon(Icons.map),
      ),
    );
  }
}
