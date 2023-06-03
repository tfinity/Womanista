import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:womanista/screens/modules/RideBooking/DriverSide/ride_requests_provider.dart';
import 'package:womanista/screens/modules/RideBooking/map_provider.dart';
import 'package:womanista/screens/modules/RideBooking/place_service.dart';
import 'package:womanista/screens/modules/RideBooking/rides_provider.dart';
import 'package:womanista/variables/variables.dart';

class RideRequests extends StatefulWidget {
  const RideRequests({Key? key}) : super(key: key);

  @override
  State<RideRequests> createState() => _RideRequestsState();
}

class _RideRequestsState extends State<RideRequests> {
  double? lat;
  double? lng;
  List<String> distances = [];
  Stream<QuerySnapshot<Map<String, dynamic>>>? snapshot;
  late LocationData curr;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getrides();
  }

  getrides() async {
    Location location = Location();
    curr = await location.getLocation();
    final user = FirebaseAuth.instance.currentUser;
    log("here");
    //context.read<RequestProvider>().requests.clear();
    snapshot = FirebaseFirestore.instance
        .collection("Rides")
        .where("requested driver", isEqualTo: user!.uid)
        .where("ride status", isEqualTo: "pending")
        .snapshots();
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    snapshot!.listen((event) {}).cancel();
    snapshot = null;
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    context.dependOnInheritedWidgetOfExactType();
  }

  @override
  Widget build(BuildContext context) {
    RequestProvider requests = Provider.of<RequestProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          // pushAndRemoveUntil(
          //     MaterialPageRoute(
          //       builder: (_) => const Home(),
          //     ),
          //     (route) => false),
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Ride Requests",
          style: AppSettings.textStyle(textColor: Colors.white, size: 20),
        ),
        backgroundColor: AppSettings.mainColor,
      ),
      body: snapshot == null
          ? Center(
              child: Column(
                children: [
                  CircularProgressIndicator(
                    color: AppSettings.mainColor,
                  ),
                  const Text(
                    "Looking for Requests",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )
          : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: snapshot,
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(
                          color: AppSettings.mainColor,
                        ),
                        const Text(
                          "Looking for Requests",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  );
                }
                if (snap.hasError) {
                  return const Center(
                    child: Text("Error Occured Try again"),
                  );
                }
                log("${snap.data!.docs.length}");
                context.read<RequestProvider>().requests.clear();
                for (var element in snap.data!.docs) {
                  PickupLocation pickupLocation = PickupLocation();
                  pickupLocation.lat = element['pickup location']['lat'];
                  pickupLocation.long = element['pickup location']['lng'];
                  pickupLocation.name = element['pickup location']['name'];
                  DestinationLocation destinationLocation =
                      DestinationLocation();
                  destinationLocation.lat = element['drop location']['lat'];
                  destinationLocation.long = element['drop location']['lng'];
                  destinationLocation.name = element['drop location']['name'];
                  // String distance =  calculateDistance(
                  //     element['pickup location']['lat'],
                  //     element['pickup location']['lng'],
                  //     curr.latitude!,
                  //     curr.longitude!);
                  //distances.add(distance);
                  context.read<RequestProvider>().addRequest(
                        Requests(
                          id: element.id,
                          pickup: pickupLocation,
                          destination: destinationLocation,
                          price: element.data()['price'],
                          riderID: element.data()['rider id'],
                        ),
                      );
                }
                return ListView.builder(
                  itemCount: requests.requests.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Pickup: ",
                                  style: AppSettings.textStyle(),
                                ),
                                Flexible(
                                  child: Text(
                                    requests.requests[index].pickup!.name,
                                    style: AppSettings.textStyle(),
                                    textAlign: TextAlign.right,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Destination: ",
                                  style: AppSettings.textStyle(),
                                ),
                                Flexible(
                                  child: Text(
                                    requests.requests[index].destination!.name,
                                    style: AppSettings.textStyle(),
                                    textAlign: TextAlign.right,
                                  ),
                                )
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text(
                            //       "Distance: ",
                            //       style: AppSettings.textStyle(),
                            //     ),
                            //     Flexible(
                            //       child: Text(
                            //         distances[index],
                            //         style: AppSettings.textStyle(),
                            //       ),
                            //     )
                            //   ],
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("Rides")
                                        .doc(requests.requests[index].id)
                                        .update({
                                      'request': 'rejected',
                                      'requested driver': '',
                                    });
                                  },
                                  child: Text(
                                    "Decline",
                                    style: AppSettings.textStyle(
                                        textColor: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {});
                                    FirebaseFirestore.instance
                                        .collection("Rides")
                                        .doc(requests.requests[index].id)
                                        .update({
                                      'request': 'accepted',
                                      'driver location': {
                                        'lat': curr.latitude,
                                        'lng': curr.longitude,
                                        'name': 'Driver',
                                      }
                                    }).then((value) {
                                      Navigator.of(context).pop();
                                      context.read<RequestProvider>().id =
                                          requests.requests[index].id;
                                      context.read<RequestProvider>().index =
                                          index;
                                      context
                                          .read<RideProvider>()
                                          .pageIncrement();
                                      final marker = Marker(
                                        markerId: const MarkerId("Driver"),
                                        infoWindow: const InfoWindow(
                                          title: "Driver",
                                        ),
                                        position: LatLng(
                                            curr.latitude!, curr.longitude!),
                                      );
                                      context.read<AppMap>().moveMap(
                                            curr.latitude!,
                                            curr.longitude!,
                                          );
                                      context
                                          .read<AppMap>()
                                          .addMarker(marker, "Driver");
                                      // context
                                      //     .read<RequestProvider>()
                                      //     .updateDrivermarker(context);
                                    });
                                  },
                                  child: Text(
                                    "Accept",
                                    style: AppSettings.textStyle(
                                        textColor: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppSettings.mainColor),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
    );
  }
}
