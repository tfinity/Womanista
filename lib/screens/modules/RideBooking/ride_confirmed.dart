import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:womanista/screens/Home.dart';
import 'package:womanista/screens/modules/RideBooking/ChatScreen.dart';
import 'package:womanista/screens/modules/RideBooking/DriverSide/ride_requests_provider.dart';
import 'package:womanista/screens/modules/RideBooking/map_provider.dart';
import 'package:womanista/screens/modules/RideBooking/rides_provider.dart';
import 'package:womanista/variables/variables.dart';

class RideConfirmed extends StatefulWidget {
  const RideConfirmed({Key? key}) : super(key: key);

  @override
  State<RideConfirmed> createState() => _RideConfirmedState();
}

class _RideConfirmedState extends State<RideConfirmed> {
  Timer? timer;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? snapshot;
  @override
  void initState() {
    super.initState();
    checkDriver();
  }

  checkDriver() {
    snapshot = FirebaseFirestore.instance
        .collection("Rides")
        .doc(AppSettings.isDriverMode
            ? context.read<RequestProvider>().id
            : context.read<RideProvider>().rideid)
        .snapshots()
        .listen((event) {
      var data = event.data()!;
      if (data['ride status'] == 'started') {
        timer?.cancel();
        timer = null;
        snapshot?.cancel();
        if (!AppSettings.isDriverMode) {
          context.read<RideProvider>().pageIncrement();
        }
      }
      if (data['ride status'] == 'completed') {
        snapshot?.cancel();
        timer?.cancel();
        timer = null;
        showCOmpleteDialoge();
      }
      if (data['ride status'] == 'canceled') {
        snapshot?.cancel();
        timer?.cancel();
        timer = null;
        showCanceledDialoge();
      }
      if (data['ride status'] != 'started') {
        if (timer == null) {
          log("updating driver");
          timer = Timer.periodic(const Duration(seconds: 7), (timer) async {
            Location location = Location();
            final curr = await location.getLocation();
            context
                .read<AppMap>()
                .updateMarker("Driver", curr.latitude!, curr.longitude!);
            FirebaseFirestore.instance
                .collection("Rides")
                .doc(AppSettings.isDriverMode
                    ? context.read<RequestProvider>().id
                    : context.read<RideProvider>().rideid)
                .update({
              'driver location': {
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

  showCanceledDialoge() {
    showDialog(
        context: context,
        builder: (ctx) {
          return Dialog(
            child: Column(
              children: [
                Text(
                  "Ride Canceled",
                  style:
                      AppSettings.textStyle(textColor: AppSettings.mainColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Ride Canceled by user",
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
          );
        });
  }

  showCOmpleteDialoge() {
    showDialog(
        context: context,
        builder: (ctx) {
          return Dialog(
            child: Column(
              children: [
                Text(
                  "Ride Completed",
                  style:
                      AppSettings.textStyle(textColor: AppSettings.mainColor),
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
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    if (AppSettings.isDriverMode) {
      return Container(
        padding: const EdgeInsets.all(20),
        height: screenSize.height,
        width: screenSize.width,
        child: Column(
          children: [
            const Spacer(),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    const Text("Go To Pickup Location then hit Start"),
                    SizedBox(
                      height: screenSize.height * 0.03,
                    ),
                    Row(
                      children: [
                        const Text("Contact Customer: "),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ChatScreen(
                                  id: AppSettings.isDriverMode
                                      ? context.read<RequestProvider>().id
                                      : context.read<RideProvider>().rideid,
                                ),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.chat,
                            color: AppSettings.mainColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenSize.height * 0.04,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppSettings.mainColor,
                      ),
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection("Rides")
                            .doc(context.read<RequestProvider>().id)
                            .update({
                          'ride status': 'started',
                        });
                        //context.read<RequestProvider>().cancelTimer();
                        //snapshot?.cancel();
                        timer?.cancel();
                        context.read<RideProvider>().pageIncrement();
                      },
                      child: const Text("Start"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      Ride ride = Provider.of<RideProvider>(context)
          .rides[Provider.of<RideProvider>(context).chooseRide];

      return Container(
        padding: const EdgeInsets.all(20),
        height: screenSize.height,
        width: screenSize.width,
        child: Column(
          children: [
            const Spacer(),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Driver on his Way",
                      style: AppSettings.textStyle(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(
                          child: Icon(
                            Icons.person,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '  ' + ride.driver!.name,
                            style: AppSettings.textStyle(),
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                  id: AppSettings.isDriverMode
                                      ? context.read<RequestProvider>().id
                                      : context.read<RideProvider>().rideid,
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.message,
                            color: AppSettings.mainColor,
                          ),
                        ),
                        // IconButton(
                        //   onPressed: () {},
                        //   icon: Icon(
                        //     Icons.call,
                        //     color: AppSettings.mainColor,
                        //   ),
                        // ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ride.carName,
                          style:
                              AppSettings.textStyle(textColor: Colors.black54),
                        ),
                        Text(
                          "Arriving in",
                          style:
                              AppSettings.textStyle(textColor: Colors.black54),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ride.carNumber,
                          style: AppSettings.textStyle(size: 18),
                        ),
                        Text(
                          "3 mins",
                          style: AppSettings.textStyle(size: 18),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      child: ElevatedButton(
                        onPressed: () {
                          //context.read<RideProvider>().pageIncrement();
                          FirebaseFirestore.instance
                              .collection("Rides")
                              .doc(AppSettings.isDriverMode
                                  ? context.read<RequestProvider>().id
                                  : context.read<RideProvider>().rideid)
                              .update({'ride status': 'canceled'});
                        },
                        child: Text(
                          "Cancel Ride",
                          style: AppSettings.textStyle(textColor: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
