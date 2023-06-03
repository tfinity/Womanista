import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:womanista/screens/modules/RideBooking/DriverSide/requestsPage.dart';
import 'package:womanista/screens/modules/RideBooking/address_search.dart';
import 'package:womanista/screens/modules/RideBooking/confirm_ride.dart';
import 'package:womanista/screens/modules/RideBooking/map_provider.dart';
import 'package:womanista/screens/modules/RideBooking/place_service.dart';
import 'package:womanista/screens/modules/RideBooking/rides_provider.dart';
import 'package:womanista/variables/variables.dart';
import 'package:location/location.dart';

class Chooseride extends StatefulWidget {
  const Chooseride({
    Key? key,
  }) : super(key: key);
  @override
  State<Chooseride> createState() => _ChooserideState();
}

class _ChooserideState extends State<Chooseride> {
  Location location = Location();

  bool destinationPicked = false;

  List<Ride> testRides = [
    Ride(
      carName: 'this car',
      capacity: 2,
      carNumber: 'LXC-2020',
      driver: Driver(
          name: 'This Driver', rating: 4.1, ridesCompleted: 9, verified: true),
      price: 240,
      img: 'car.png',
    ),
    Ride(
      carName: 'that car',
      capacity: 3,
      carNumber: 'LXC-2019',
      driver: Driver(
          name: 'Again This Driver',
          rating: 0,
          ridesCompleted: 0,
          verified: false),
      price: 150,
      img: 'car.png',
    ),
    Ride(
      carName: 'again this car',
      capacity: 2,
      carNumber: 'LXC-555',
      driver: Driver(
          name: 'That Driver', rating: 3.9, ridesCompleted: 50, verified: true),
      price: 560,
      img: 'car.png',
    ),
    Ride(
      carName: 'again that car',
      capacity: 2,
      carNumber: 'LXC-987',
      driver: Driver(
          name: 'Again This Driver',
          rating: 4.5,
          ridesCompleted: 10,
          verified: false),
      price: 630,
      img: 'car.png',
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAvailableRides();
  }

  fetchAvailableRides() {
    context.read<RideProvider>().setSnapshot(FirebaseFirestore.instance
        .collection("Drivers")
        .where("available", isEqualTo: true)
        .snapshots());
  }

  void alertCall(String text) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Alert!!"),
            content: Text(text),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppSettings.mainColor),
                child: Text(
                  "OK",
                  style: AppSettings.textStyle(textColor: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  Widget startButton(BuildContext context) {
    if (AppSettings.isDriverMode) {
      return ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const RideRequests(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppSettings.mainColor,
        ),
        child: const Text("Available Rides"),
      );
    }
    return ElevatedButton(
      onPressed: () {
        log("destinationPicked: $destinationPicked");
        // if (!destinationPicked) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(
        //       content: Text("Pick Destination Location"),
        //     ),
        //   );
        //   return;
        // }
        FirebaseFirestore.instance.collection("Rides").add({
          'pickup location': {
            'name': Provider.of<PickupLocation>(context, listen: false).name,
            'lat': Provider.of<PickupLocation>(context, listen: false).lat,
            'lng': Provider.of<PickupLocation>(context, listen: false).long,
          },
          'drop location': {
            'name':
                Provider.of<DestinationLocation>(context, listen: false).name,
            'lat': Provider.of<DestinationLocation>(context, listen: false).lat,
            'lng':
                Provider.of<DestinationLocation>(context, listen: false).long,
          },
          'ride status': 'pending',
        }).then((value) {
          context.read<RideProvider>().setId(value.id);
          context.read<RideProvider>().start = true;
          setState(() {});
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppSettings.mainColor,
      ),
      child: const Text("Start"),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding:
          EdgeInsets.fromLTRB(15, MediaQuery.of(context).padding.top, 15, 15),
      height: screenSize.height,
      width: screenSize.width,
      child: Column(
        children: [
          appBar(context),
          if (!AppSettings.isDriverMode) locationpick(context, screenSize),
          const Spacer(),
          context.read<RideProvider>().start
              ? availableRides(context, screenSize)
              : startButton(context),
        ],
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return Card(
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          Text(
            AppSettings.isDriverMode ? "Get a Ride" : "Book a Ride",
            style: AppSettings.textStyle(size: 20),
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Switch(
                value: AppSettings.isDriverMode,
                onChanged: (v) async {
                  context.read<RideProvider>().resetPage();
                  context.read<RideProvider>().start = false;
                  FirebaseFirestore.instance
                      .collection("Users")
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .get()
                      .then(
                    (value) {
                      final data = value.data() ??
                          {
                            "Driver": false,
                            "Driver Application": false,
                          };
                      if (data["Driver"]) {
                        if (data["Driver Application"] == "Approved") {
                          AppSettings.isDriverMode = v;
                          setState(() {});
                          var email = FirebaseAuth.instance.currentUser?.email;
                          FirebaseFirestore.instance
                              .collection("Drivers")
                              .doc(email)
                              .update({
                            "available": v,
                            'uid': FirebaseAuth.instance.currentUser!.uid,
                          });
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => const RideRequests(),
                          //   ),
                          // );
                        } else {
                          alertCall("Chack your Driver Application status");
                        }
                      } else {
                        alertCall(
                            "You Need to Register as a Driver to Activate this Feature");
                      }
                    },
                  );
                },
              ),
              //Text("Driver Mode: ${isDriverMode ? 'On' : 'Off'}"),
            ],
          ),
          // InkWell(
          //   onTap: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (context) => const RideRequests(),
          //       ),
          //     );
          //   },
          //   child: const CircleAvatar(
          //     child: Icon(
          //       Icons.person,
          //     ),
          //   ),
          // ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }

  Widget locationpick(BuildContext context, Size screenSize) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Column(
              children: [
                const Icon(
                  Icons.circle,
                  size: 10,
                  color: Colors.blue,
                ),
                Container(
                  height: screenSize.height * 0.05,
                  color: Colors.black54,
                  width: 1,
                ),
                const Icon(
                  Icons.circle,
                  size: 10,
                  color: Colors.red,
                ),
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "From",
                  style: AppSettings.textStyle(
                    textColor: Colors.black54,
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.03,
                ),
                Text(
                  "To",
                  style: AppSettings.textStyle(
                    textColor: Colors.black54,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: screenSize.width * 0.05,
            ),
            SizedBox(
              width: screenSize.width * 0.55,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final sessionToken = const Uuid().v4();
                            Suggestion? result = await showSearch(
                              context: context,
                              delegate:
                                  AddressSearch(sessionToken: sessionToken),
                            );
                            if (result?.placeId == "") {
                              return;
                            }
                            var latlong = await PlaceApiProvider(sessionToken)
                                .getPlaceDetailFromId(result!.placeId);
                            context.read<PickupLocation>().adddata(
                                result.description,
                                latlong["lat"],
                                latlong['lng']);
                            final marker = Marker(
                              markerId: const MarkerId("current"),
                              infoWindow: const InfoWindow(
                                title: "Pickup Location",
                              ),
                              position: LatLng(latlong["lat"], latlong['lng']),
                            );
                            context.read<AppMap>().moveMap(
                                  latlong["lat"],
                                  latlong['lng'],
                                );
                            context
                                .read<AppMap>()
                                .addMarker(marker, "Pickup Location");
                          },
                          child: Text(
                            Provider.of<PickupLocation>(context).name,
                            style: AppSettings.textStyle(),
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          var currentLocation = await location.getLocation();
                          log("${currentLocation.heading}");
                          log("${currentLocation.latitude}");
                          log("${currentLocation.longitude}");
                          // GoogleMapController controller =
                          //     await widget.controller.future;
                          context.read<PickupLocation>().adddata(
                              "Your Location",
                              currentLocation.latitude!,
                              currentLocation.longitude!);
                          final marker = Marker(
                            markerId: const MarkerId("current"),
                            infoWindow: const InfoWindow(
                              title: "Your Location",
                            ),
                            position: LatLng(currentLocation.latitude!,
                                currentLocation.longitude!),
                          );
                          context.read<AppMap>().moveMap(
                                currentLocation.latitude!,
                                currentLocation.longitude!,
                              );
                          context.read<AppMap>().addMarker(marker, "current");
                        },
                        icon: const Icon(Icons.location_on),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.03,
                  ),
                  InkWell(
                    onTap: () async {
                      final sessionToken = const Uuid().v4();
                      Suggestion? result = await showSearch(
                        context: context,
                        delegate: AddressSearch(sessionToken: sessionToken),
                      );
                      var latlong = await PlaceApiProvider(sessionToken)
                          .getPlaceDetailFromId(result!.placeId);
                      context.read<DestinationLocation>().adddata(
                          result.description, latlong["lat"], latlong['lng']);
                      // GoogleMapController controller =
                      //     await widget.controller.future;
                      destinationPicked = true;
                      log("destinationPicked: $destinationPicked");
                      context
                          .read<AppMap>()
                          .moveMap(latlong["lat"], latlong['lng']);
                      final marker = Marker(
                        markerId: const MarkerId("Destination"),
                        infoWindow: const InfoWindow(
                          title: "Destination",
                        ),
                        position: LatLng(latlong["lat"], latlong['lng']),
                      );
                      context.read<AppMap>().addMarker(marker, "destination");
                    },
                    child: Text(
                      Provider.of<DestinationLocation>(context).name,
                      style: AppSettings.textStyle(),
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget availableRides(BuildContext context, Size screenSize) {
    var rideProvider = context.read<RideProvider>();
    rideProvider.rides = testRides;

    return Card(
      child: Container(
        height: screenSize.height * 0.38,
        width: screenSize.width * 0.9,
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Available Rides",
              style: AppSettings.textStyle(),
            ),
            Expanded(
              child: Center(
                child: rideProvider.snapshot == null
                    ? Text(
                        'Finding nearby rides...',
                        style: AppSettings.textStyle(textColor: Colors.black54),
                      )
                    : StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: rideProvider.snapshot,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.waiting ||
                              snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: Text(
                                'Finding nearby rides...',
                                style: AppSettings.textStyle(
                                    textColor: Colors.black54),
                              ),
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                'Error Occured Try again',
                                style: AppSettings.textStyle(
                                    textColor: Colors.black54),
                              ),
                            );
                          }
                          rideProvider.rides = [];
                          log("asas: ${snapshot.data!.docs.length}");

                          for (var element in snapshot.data!.docs) {
                            var data = element.data();
                            rideProvider.add(Ride(
                              carName: data['cnic'],
                              capacity: 2,
                              carNumber: data['Vehicle License'],
                              driver: Driver(
                                  uid: data['uid'],
                                  name: data['Full Name'],
                                  rating: 4.5,
                                  ridesCompleted: 10,
                                  verified: data['status'] == "approved"),
                              price: 530,
                              img: data['Vehicle Image'],
                            ));
                          }
                          return ListView.builder(
                            itemCount: rideProvider.rides.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              Color color = Provider.of<RideProvider>(context)
                                          .chooseRide !=
                                      index
                                  ? Colors.black
                                  : Colors.white;
                              return InkWell(
                                onTap: () {
                                  rideProvider.selectRide(index);
                                  print(rideProvider.chooseRide);
                                },
                                child: Card(
                                  color: Provider.of<RideProvider>(context)
                                              .chooseRide ==
                                          index
                                      ? AppSettings.mainColorLignt
                                      : Colors.white,
                                  child: SizedBox(
                                    width: screenSize.width * 0.45,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          rideProvider.rides[index].carName,
                                          style: AppSettings.textStyle(
                                            weight: FontWeight.bold,
                                            textColor: color,
                                          ),
                                        ),
                                        Text(
                                          rideProvider.rides[index].carNumber,
                                          style: AppSettings.textStyle(
                                            size: 14,
                                            textColor: color,
                                          ),
                                        ),
                                        Text(
                                          "${rideProvider.rides[index].capacity} person can ride",
                                          style: AppSettings.textStyle(
                                            size: 12,
                                            textColor: color,
                                          ),
                                        ),
                                        SizedBox(
                                          height: screenSize.height * 0.1,
                                          child: Image.network(
                                            rideProvider.rides[index].img,
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                        Text(
                                          "Rs. ${rideProvider.rides[index].price}",
                                          style: AppSettings.textStyle(
                                            textColor: color,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }),
              ),
            ),
            Align(
              child: ElevatedButton(
                onPressed: Provider.of<RideProvider>(context).chooseRide == -1
                    ? null
                    : () {
                        int index = context.read<RideProvider>().chooseRide;
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DriverDetails(
                              ride: rideProvider.rides[index],
                            ),
                          ),
                        );
                      },
                child: Text(
                  "Book Ride",
                  style:
                      AppSettings.textStyle(size: 20, textColor: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppSettings.mainColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
