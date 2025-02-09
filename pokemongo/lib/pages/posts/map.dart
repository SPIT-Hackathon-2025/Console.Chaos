import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:pokemongo/constants.dart';
import 'package:pokemongo/controller/map_controller.dart';

class NormalPosts extends StatelessWidget {
  NormalPosts({super.key});
  final MumbaiMapController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(19.0760, 72.8777), // Mumbai center
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: controller.markerLocations.map((location) {
                return Marker(
                  width: 60.0,
                  height: 60.0,
                  point: location,
                  child: Icon(Icons.location_pin, color: Colors.red, size: 40),
                );
              }).toList(),
            ),
          ],
        ));
  }
}
