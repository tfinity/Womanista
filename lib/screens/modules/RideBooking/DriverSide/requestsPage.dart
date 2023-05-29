import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:womanista/screens/Home.dart';
import 'package:womanista/screens/modules/RideBooking/DriverSide/ride_requests_provider.dart';
import 'package:womanista/screens/modules/RideBooking/distance_work.dart';
import 'package:womanista/screens/modules/RideBooking/place_service.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getrides();
  }

  getrides() async {
    Location location = Location();
    final curr = await location.getLocation();
    log("here");
    FirebaseFirestore.instance.collection("Rides").get().then((value) async {
      for (var element in value.docs) {
        PickupLocation pickupLocation = PickupLocation();
        pickupLocation.lat = element['pickup location']['lat'];
        pickupLocation.long = element['pickup location']['lng'];
        pickupLocation.name = element['pickup location']['name'];
        DestinationLocation destinationLocation = DestinationLocation();
        destinationLocation.lat = element['drop location']['lat'];
        destinationLocation.long = element['drop location']['lng'];
        destinationLocation.name = element['drop location']['name'];
        String distance = await calculateDistance(
            element['pickup location']['lat'],
            element['pickup location']['lng'],
            curr.latitude!,
            curr.longitude!);
        distances.add(distance);
        context.read<RequestProvider>().requests.add(
              Requests(
                pickup: pickupLocation,
                destination: destinationLocation,
              ),
            );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    RequestProvider requests = Provider.of<RequestProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => const Home(),
              ),
              (route) => false),
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Ride Requests",
          style: AppSettings.textStyle(textColor: Colors.white, size: 20),
        ),
        backgroundColor: AppSettings.mainColor,
      ),
      body: requests.requests.isEmpty
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
          : ListView.builder(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Distance: ",
                              style: AppSettings.textStyle(),
                            ),
                            Flexible(
                              child: Text(
                                distances[index],
                                style: AppSettings.textStyle(),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
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
                              onPressed: () {},
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
            ),
    );
  }
}
