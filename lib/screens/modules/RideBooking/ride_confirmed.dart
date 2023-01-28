import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanista/screens/modules/RideBooking/ChatScreen.dart';
import 'package:womanista/screens/modules/RideBooking/rides_provider.dart';
import 'package:womanista/variables/variables.dart';

class RideConfirmed extends StatefulWidget {
  const RideConfirmed({Key? key}) : super(key: key);

  @override
  State<RideConfirmed> createState() => _RideConfirmedState();
}

class _RideConfirmedState extends State<RideConfirmed> {
  @override
  void initState() {
    super.initState();
  }

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
                      Text(
                        '  ' + ride.driver!.name,
                        style: AppSettings.textStyle(),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ChatScreen(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.message,
                          color: AppSettings.mainColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.call,
                          color: AppSettings.mainColor,
                        ),
                      ),
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
                        style: AppSettings.textStyle(textColor: Colors.black54),
                      ),
                      Text(
                        "Arriving in",
                        style: AppSettings.textStyle(textColor: Colors.black54),
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
                        context.read<RideProvider>().pageIncrement();
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
