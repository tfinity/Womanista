import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:womanista/screens/modules/RideBooking/choose_ride.dart';
import 'package:womanista/screens/modules/RideBooking/map_provider.dart';
import 'package:womanista/screens/modules/RideBooking/place_service.dart';
import 'package:womanista/screens/modules/RideBooking/ride_confirmed.dart';
import 'package:womanista/screens/modules/RideBooking/ride_in_progress.dart';
import 'package:womanista/screens/modules/RideBooking/rides_provider.dart';

class RideBookingHome extends StatefulWidget {
  const RideBookingHome({Key? key}) : super(key: key);

  @override
  State<RideBookingHome> createState() => _RideBookingHomeState();
}

class _RideBookingHomeState extends State<RideBookingHome> {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(31.5826, 74.3276),
    zoom: 14.4746,
  );
  Location location = Location();

  bool visible = true;

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  requestPermissions() async {
    await [
      Permission.location,
    ].request();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    context.read<AppMap>().remove();
    super.dispose();
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
                onMapCreated: (GoogleMapController controller) async {
                  context.read<AppMap>().controller.complete(controller);
                  var currentLocation = await location.getLocation();
                  log("${currentLocation.heading}");
                  log("${currentLocation.latitude}");
                  log("${currentLocation.longitude}");
                  context.read<PickupLocation>().adddata("Your Location",
                      currentLocation.latitude!, currentLocation.longitude!);
                  // GoogleMapController controller =
                  //     await widget.controller.future;
                  final marker = Marker(
                    markerId: const MarkerId("current"),
                    infoWindow: const InfoWindow(
                      title: "Your Location",
                    ),
                    position: LatLng(
                        currentLocation.latitude!, currentLocation.longitude!),
                  );
                  context.read<AppMap>().moveMap(
                        currentLocation.latitude!,
                        currentLocation.longitude!,
                      );
                  context.read<AppMap>().addMarker(marker, "current");
                  // _controller.complete(controller);
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
                markers: context.read<AppMap>().markers.values.toSet(),
                // polylines: ,
              ),
              Visibility(
                visible: visible,
                child: IndexedStack(
                  index: Provider.of<RideProvider>(context).visiblePage,
                  children: const [
                    Chooseride(),
                    RideConfirmed(),
                    RideInProgress(),
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
