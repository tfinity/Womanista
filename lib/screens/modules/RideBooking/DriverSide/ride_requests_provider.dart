import 'package:flutter/cupertino.dart';
import 'package:womanista/screens/modules/RideBooking/place_service.dart';
import 'package:womanista/screens/modules/RideBooking/rides_provider.dart';

class Requests {
  PickupLocation? pickup;
  DestinationLocation? destination;
  Ride? ride;
  Requests({this.pickup, this.destination, this.ride});
}

class RequestProvider with ChangeNotifier {
  List<Requests> requests = [];

  addRequest(Requests req) {
    requests.add(req);
    notifyListeners();
  }
}
