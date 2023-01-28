import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanista/screens/modules/RideBooking/place_service.dart';
import 'package:womanista/screens/modules/RideBooking/rides_provider.dart';
import 'package:womanista/variables/variables.dart';

class RideInProgress extends StatefulWidget {
  const RideInProgress({Key? key}) : super(key: key);

  @override
  State<RideInProgress> createState() => _RideInProgressState();
}

class _RideInProgressState extends State<RideInProgress> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
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
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenSize.width * 0.5,
                        child: Text(
                          Provider.of<DestinationLocation>(context).name,
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
                        "You will Pay: ",
                        style: AppSettings.textStyle(),
                      ),
                      Text(
                        "Rs.${ride.price}",
                        style: AppSettings.textStyle(size: 20),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<RideProvider>().resetPage();
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
