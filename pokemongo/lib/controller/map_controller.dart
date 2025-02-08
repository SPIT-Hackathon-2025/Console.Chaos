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
      LatLng(19.0760, 72.8777), // Mumbai
      LatLng(19.2183, 72.9781), // Sanjay Gandhi National Park
      LatLng(18.9220, 72.8347), // Gateway of India
      LatLng(19.0176, 72.8562), // Marine Drive
      LatLng(19.0728, 72.8826), // Siddhivinayak Temple
      LatLng(19.1231786, 72.8362765)
    ]);
  }
}