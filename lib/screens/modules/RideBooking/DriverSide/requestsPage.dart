import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanista/screens/modules/RideBooking/DriverSide/ride_requests_provider.dart';
import 'package:womanista/variables/variables.dart';

class RideRequests extends StatefulWidget {
  const RideRequests({Key? key}) : super(key: key);

  @override
  State<RideRequests> createState() => _RideRequestsState();
}

class _RideRequestsState extends State<RideRequests> {
  @override
  Widget build(BuildContext context) {
    RequestProvider requests = Provider.of<RequestProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ride Requests",
          style: AppSettings.textStyle(textColor: Colors.white, size: 20),
        ),
        backgroundColor: AppSettings.mainColor,
      ),
      body: ListView.builder(
        itemCount: 3, //requests.requests.length,
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
                      Text(
                        "Shalamar Bagh",
                        style: AppSettings.textStyle(),
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
                      Text(
                        "Saddar Gol Chakkar",
                        style: AppSettings.textStyle(),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ride Price: ",
                        style: AppSettings.textStyle(),
                      ),
                      Text(
                        "Rs. 350",
                        style: AppSettings.textStyle(),
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
                          style: AppSettings.textStyle(textColor: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Accept",
                          style: AppSettings.textStyle(textColor: Colors.white),
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
