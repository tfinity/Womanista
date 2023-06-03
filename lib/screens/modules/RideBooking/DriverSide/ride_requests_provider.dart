import 'package:flutter/cupertino.dart';
import 'package:womanista/screens/modules/RideBooking/place_service.dart';
import 'package:womanista/screens/modules/RideBooking/rides_provider.dart';

class Requests {
  String id;
  PickupLocation? pickup;
  DestinationLocation? destination;
  Ride? ride;
  String price;
  String riderID;
  Requests(
      {this.id = '',
      this.price = '',
      this.riderID = '',
      this.pickup,
      this.destination,
      this.ride});
}

class RequestProvider with ChangeNotifier {
  List<Requests> requests = [];
  String id = '';
  int index = 0;

  addRequest(Requests req) {
    requests.add(req);
    notifyListeners();
  }

  void updateDrivermarker(BuildContext context) {}

  void cancelTimer() {}
}
