import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanista/screens/modules/RideBooking/rides_provider.dart';
import 'package:womanista/variables/variables.dart';

class DriverDetails extends StatelessWidget {
  const DriverDetails({Key? key, required this.ride}) : super(key: key);
  final Ride ride;

  @override
  Widget build(BuildContext context) {
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
          Image.asset("assets/${ride.img}"),
          ElevatedButton(
            onPressed: () {
              context.read<RideProvider>().pageIncrement();
              Navigator.of(context).pop();
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
}
