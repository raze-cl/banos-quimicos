import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../data/models/route_model.dart';

class RouteMapPage extends StatelessWidget {
  final RouteModel route;

  const RouteMapPage({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    // Coordenadas base de faena (Escondida como ejemplo: -24.2713, -69.0664)
    const centerLatLng = LatLng(-24.2713, -69.0664);

    // Generar marcadores georreferenciados simulados para los puntos de control en la zona
    final List<Marker> markers = [];
    final List<LatLng> polylinePoints = [];

    for (int i = 0; i < route.points.length; i++) {
      final pt = route.points[i];
      // Desplazar levemente cada punto para simular ubicaciones en el mapa
      final ptLatLng = LatLng(
        centerLatLng.latitude + (i * 0.003) - 0.003,
        centerLatLng.longitude + (i * 0.004) - 0.004,
      );

      polylinePoints.add(ptLatLng);

      Color markerColor = Colors.grey;
      if (pt.status == 'COMPLETED') {
        markerColor = Colors.green;
      } else if (pt.status == 'OMITTED') {
        markerColor = Colors.orange;
      } else if (pt.status == 'PENDING') {
        markerColor = Colors.blueAccent;
      }

      markers.add(
        Marker(
          point: ptLatLng,
          width: 80,
          height: 80,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  pt.name,
                  style: const TextStyle(
                    fontSize: 9,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(Icons.location_pin, color: markerColor, size: 32),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('MAPA OPERACIONAL: ${route.name}'),
        backgroundColor: const Color(0xFF1E293B),
      ),
      body: FlutterMap(
        options: const MapOptions(initialCenter: centerLatLng, initialZoom: 14.0),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.antigravity.gestion_operacional',
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: polylinePoints,
                color: Colors.blueAccent.withValues(alpha: 0.6),
                strokeWidth: 4.0,
                isDotted: true,
              ),
            ],
          ),
          MarkerLayer(markers: markers),
        ],
      ),
    );
  }
}
