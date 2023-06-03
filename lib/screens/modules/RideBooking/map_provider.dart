import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppMap with ChangeNotifier {
  Completer<GoogleMapController> controller = Completer<GoogleMapController>();

  Map<String, Marker> markers = {};

  createMap() {}
  void addMarker(Marker m, String name) {
    markers[m.markerId.value] = m;
    notifyListeners();
  }

  void moveMap(double lat, double long) async {
    (await controller.future).animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            bearing: 192.8334901395799,
            target: LatLng(lat, long),
            tilt: 59.440717697143555,
            zoom: 19.151926040649414),
      ),
    );
  }

  updateMarker(String id, double lat, double lng) {
    markers[id] = Marker(
        markerId: MarkerId(id),
        infoWindow: markers[id]!.infoWindow,
        position: LatLng(lat, lng));
    moveMap(lat, lng);
  }

  void remove() async {
    (await controller.future).dispose();
  }

  drawPath() {
    // Polyline(polylineId: PolylineId("direction"),)
  }
}
