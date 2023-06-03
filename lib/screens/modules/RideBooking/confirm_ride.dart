import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:womanista/screens/modules/RideBooking/map_provider.dart';
import 'package:womanista/screens/modules/RideBooking/rides_provider.dart';
import 'package:womanista/variables/variables.dart';

class DriverDetails extends StatelessWidget {
  const DriverDetails({Key? key, required this.ride}) : super(key: key);
  final Ride ride;

  trackDriveravailability(BuildContext context) {
    FirebaseFirestore.instance
        .collection("Drivers")
        .where("uid", isEqualTo: ride.driver!.uid)
        .limit(1)
        .snapshots()
        .take(1)
        .listen((event) {
      var data = event.docs[0].data();
      if (data['available'] == false) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text("Driver Not Available"),
                content: const Text("Driver has Become unavailable"),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      Navigator.of(context).pop();
                    },
                    child: const Text("Ok"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppSettings.mainColor,
                    ),
                  ),
                ],
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    trackDriveravailability(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppSettings.mainColor,
        title: const Text("Rider Details"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 20,
              ),
              CircleAvatar(
                child: Icon(
                  Icons.person,
                  size: size.height * 0.05,
                ),
                radius: size.height * 0.05,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                ride.driver!.name,
                style: AppSettings.textStyle(size: 22, weight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                "Rating: ",
                style: AppSettings.textStyle(),
              ),
              const Icon(
                Icons.star,
                color: Colors.yellow,
              ),
              Text(
                "3.5",
                style: AppSettings.textStyle(),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                "Uid: ",
                style: AppSettings.textStyle(),
              ),
              Text(
                ride.driver!.uid,
                style: AppSettings.textStyle(),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                "Car Number: ",
                style: AppSettings.textStyle(),
              ),
              Text(
                ride.carNumber,
                style: AppSettings.textStyle(),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                "Car Name: ",
                style: AppSettings.textStyle(),
              ),
              Text(
                ride.carName,
                style: AppSettings.textStyle(),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                "Rides Completed: ",
                style: AppSettings.textStyle(),
              ),
              Text(
                "${ride.driver!.ridesCompleted}",
                style: AppSettings.textStyle(),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                "Verified: ",
                style: AppSettings.textStyle(),
              ),
              Text(
                "${ride.driver!.verified}",
                style: AppSettings.textStyle(),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                "Ride Price: ",
                style: AppSettings.textStyle(),
              ),
              Text(
                "${ride.price}",
                style: AppSettings.textStyle(),
              ),
            ],
          ),
          Image.network(
            ride.img,
            height: size.height * 0.25,
            width: size.width * 0.8,
          ),
          ElevatedButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection("Rides")
                  .doc(context.read<RideProvider>().rideid)
                  .update({
                'requested driver': ride.driver!.uid,
              });

              wiatforDriver(context);
            },
            child: Text("Confirm Ride",
                style: AppSettings.textStyle(textColor: Colors.white)),
            style: ElevatedButton.styleFrom(
                backgroundColor: AppSettings.mainColor),
          ),
        ],
      ),
    );
  }

  wiatforDriver(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Waiting for Driver"),
          content: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppSettings.mainColor,
            ),
          ),
        );
      },
    );
    FirebaseFirestore.instance
        .collection("Rides")
        .doc(context.read<RideProvider>().rideid)
        .snapshots()
        .take(3)
        .listen((event) async {
      var data = event.data()!;
      if (data['request'] == "rejected") {
        Navigator.of(context).pop();
        requestRejected(context);
      } else if (data['request'] == "accepted") {
        Location location = Location();
        LocationData curr = await location.getLocation();
        final marker = Marker(
          markerId: const MarkerId("Driver"),
          infoWindow: const InfoWindow(
            title: "Driver",
          ),
          position: LatLng(curr.latitude!, curr.longitude!),
        );
        context.read<AppMap>().moveMap(
              curr.latitude!,
              curr.longitude!,
            );
        context.read<AppMap>().addMarker(marker, "Driver");
        context.read<RideProvider>().pageIncrement();
        context.read<RideProvider>().cancellSnapshot();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
    });
  }

  requestRejected(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Rejected"),
            content: const Text(
                "Your Request was Rejected. Please try a Different Driver"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("Rides")
                      .doc(context.read<RideProvider>().rideid)
                      .update({"request": 'not requested'});
                  Navigator.of(ctx).pop();
                  Navigator.of(context).pop();
                },
                child: const Text("Ok"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppSettings.mainColor,
                ),
              ),
            ],
          );
        });
  }
}
