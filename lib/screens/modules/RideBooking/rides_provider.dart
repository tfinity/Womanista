import 'package:cloud_firestore/cloud_firestore.dart';
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
  int chooseRide = -1;
  int visiblePage = 0;
  String rideid = '';
  bool start = false;
  Stream<QuerySnapshot<Map<String, dynamic>>>? snapshot;

  void setId(String id) {
    rideid = id;
    notifyListeners();
  }

  void setSnapshot(Stream<QuerySnapshot<Map<String, dynamic>>> s) {
    snapshot = s;
    notifyListeners();
  }

  void cancellSnapshot() {
    snapshot!.listen((event) {}).cancel();
    snapshot = null;
    notifyListeners();
  }

  add(Ride ride) {
    rides.add(ride);
    notifyListeners();
  }

  selectRide(int index) {
    chooseRide = index;
    print(index);
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
  String uid;
  Driver(
      {this.name = '',
      this.rating = 0.0,
      this.verified = false,
      this.ridesCompleted = 0,
      this.img = '',
      this.uid = ''});
}
