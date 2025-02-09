import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MumbaiMapController extends GetxController {
  var markerLocations = <LatLng>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMarkers();
  }

  void loadMarkers() {
    markerLocations.addAll([
      LatLng(19.1231786, 72.8362765),
    ]);
  }

  void addMarker(double latitude, double longitude) {
    markerLocations.add(LatLng(latitude, longitude));
  }
}
