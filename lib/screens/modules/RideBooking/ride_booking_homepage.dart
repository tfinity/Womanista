import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:womanista/screens/modules/RideBooking/choose_ride.dart';
import 'package:womanista/screens/modules/RideBooking/ride_confirmed.dart';
import 'package:womanista/screens/modules/RideBooking/ride_in_progress.dart';
import 'package:womanista/screens/modules/RideBooking/rides_provider.dart';

class RideBookingHome extends StatefulWidget {
  const RideBookingHome({Key? key}) : super(key: key);

  @override
  State<RideBookingHome> createState() => _RideBookingHomeState();
}

class _RideBookingHomeState extends State<RideBookingHome> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(31.5826, 74.3276),
    zoom: 14.4746,
  );

  double lat = 31.5883698;
  double long = 74.38029089999999;

  CameraPosition? _kLake;

  bool visible = true;

  @override
  void initState() {
    requestPermissions();
    _kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(lat, long),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);
    super.initState();
  }

  requestPermissions() async {
    await [
      Permission.location,
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              GoogleMap(
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                initialCameraPosition: _kGooglePlex,
                //liteModeEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                scrollGesturesEnabled: true,
                zoomControlsEnabled: false,
                onCameraIdle: () {
                  visible = true;
                  setState(() {});
                },
                onCameraMoveStarted: () {
                  visible = false;
                  setState(() {});
                },
                onTap: (latlng) {
                  log("${latlng.latitude}");
                  log("${latlng.longitude}");
                },
              ),
              Visibility(
                visible: visible,
                child: IndexedStack(
                  index: Provider.of<RideProvider>(context).visiblePage,
                  children: [
                    Chooseride(controller: _controller),
                    const RideConfirmed(),
                    const RideInProgress(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake!));
  // }
}
