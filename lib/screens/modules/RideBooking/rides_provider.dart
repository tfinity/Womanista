import 'package:flutter/cupertino.dart';

class Ride {
  String carName;
  String carNumber;
  double price;
  String img;
  int capacity;
  Driver? driver;

  bool? rideConfirmed;

  Ride({
    this.driver,
    this.carName = '',
    this.carNumber = '',
    this.img = '',
    this.capacity = 0,
    this.price = 0.0,
  });
}

class RideProvider with ChangeNotifier {
  List<Ride> rides = [];
  int chooseRide = 0;
  int visiblePage = 0;

  add(Ride ride) {
    rides.add(ride);
    notifyListeners();
  }

  selectRide(int index) {
    chooseRide = index;
    notifyListeners();
  }

  pageIncrement() {
    visiblePage++;
    notifyListeners();
  }

  pageDecrement() {
    visiblePage--;
    notifyListeners();
  }

  resetPage() {
    visiblePage = 0;
    notifyListeners();
  }
}

class Driver {
  String name;
  double rating;
  int ridesCompleted;
  bool verified;
  String img;
  Driver(
      {this.name = '',
      this.rating = 0.0,
      this.verified = false,
      this.ridesCompleted = 0,
      this.img = ''});
}
