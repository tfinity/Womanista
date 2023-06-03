import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:womanista/screens/Home.dart';
import 'package:womanista/screens/modules/RideBooking/DriverSide/ride_requests_provider.dart';
import 'package:womanista/screens/modules/RideBooking/map_provider.dart';
import 'package:womanista/screens/modules/RideBooking/place_service.dart';
import 'package:womanista/screens/modules/RideBooking/rides_provider.dart';
import 'package:womanista/variables/variables.dart';

class RideInProgress extends StatefulWidget {
  const RideInProgress({Key? key}) : super(key: key);

  @override
  State<RideInProgress> createState() => _RideInProgressState();
}

class _RideInProgressState extends State<RideInProgress> {
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? snapshot;
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkRideStatus();
  }

  checkRideStatus() {
    snapshot = FirebaseFirestore.instance
        .collection("Rides")
        .doc(AppSettings.isDriverMode
            ? context.read<RequestProvider>().id
            : context.read<RideProvider>().rideid)
        .snapshots()
        .listen((event) {
      var data = event.data()!;
      if (data['ride status'] == 'completed') {
        snapshot?.cancel();
        timer?.cancel();
        timer = null;
        showCOmpleteDialoge();
      }
      if (data['ride status'] == 'started') {
        if (timer == null) {
          log("updating driver");
          timer = Timer.periodic(const Duration(seconds: 7), (timer) async {
            Location location = Location();
            final curr = await location.getLocation();
            context
                .read<AppMap>()
                .updateMarker("current", curr.latitude!, curr.longitude!);
            FirebaseFirestore.instance
                .collection("Rides")
                .doc(AppSettings.isDriverMode
                    ? context.read<RequestProvider>().id
                    : context.read<RideProvider>().rideid)
                .update({
              'pickup location': {
                'lat': curr.latitude,
                'lng': curr.longitude,
                'name': 'driver',
              }
            });
          });
        }
      }
    });
  }

  showCOmpleteDialoge() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          return WillPopScope(
            onWillPop: () => Future(() => false),
            child: Dialog(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Column(
                  children: [
                    Text(
                      "Ride Completed",
                      style: AppSettings.textStyle(
                          textColor: AppSettings.mainColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Ride Complete",
                      style: AppSettings.textStyle(size: 14),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) => const Home()),
                            (route) => false);
                      },
                      child: const Text("OK"),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Requests request = Requests();
    Ride ride = Ride();
    if (AppSettings.isDriverMode) {
      request = context
          .read<RequestProvider>()
          .requests[context.read<RequestProvider>().index];
    } else {
      ride = Provider.of<RideProvider>(context)
          .rides[Provider.of<RideProvider>(context).chooseRide];
    }
    Size screenSize = MediaQuery.of(context).size;

    var user = FirebaseFirestore.instance
        .collection("Users")
        .where("uid", isEqualTo: request.riderID)
        .get();
    return Container(
      padding: const EdgeInsets.all(20),
      height: screenSize.height,
      width: screenSize.width,
      child: Column(
        children: [
          const Spacer(),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenSize.width * 0.5,
                        child: Text(
                          AppSettings.isDriverMode
                              ? request.destination!.name
                              : Provider.of<DestinationLocation>(context).name,
                          style: AppSettings.textStyle(),
                        ),
                      ),
                      Text(
                        "5 min",
                        style: AppSettings.textStyle(size: 20),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppSettings.isDriverMode
                            ? "You will Get: "
                            : "You will Pay: ",
                        style: AppSettings.textStyle(),
                      ),
                      Text(
                        "Rs. ${AppSettings.isDriverMode ? request.price : ride.price}",
                        style: AppSettings.textStyle(size: 20),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (!AppSettings.isDriverMode)
                    ElevatedButton(
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection("Rides")
                            .doc(AppSettings.isDriverMode
                                ? context.read<RequestProvider>().id
                                : context.read<RideProvider>().rideid)
                            .update({'ride status': 'completed'});
                        //context.read<RideProvider>().resetPage();
                      },
                      child: Text(
                        "Finish Ride",
                        style: AppSettings.textStyle(
                            textColor: Colors.white, size: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppSettings.mainColor),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
