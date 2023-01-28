import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class Address {
  double lat;
  double long;
  moveMap(
    GoogleMapController c, {
    double latitude = 0,
    double longitute = 0,
  }) {
    lat = latitude;
    long = longitute;
    c.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
          bearing: 192.8334901395799,
          target: LatLng(latitude, longitute),
          tilt: 59.440717697143555,
          zoom: 19.151926040649414)),
    );
  }

  Address({this.lat = 0.0, this.long = 0.0});
}

class PickupLocation extends Address with ChangeNotifier {
  String name = 'Your Location';
  //PickupLocation({this.name = 'Your Location', lat, long}) : super(lat: lat, long: long);

  adddata(String n, double l, double ln) {
    name = n;
    lat = l;
    long = ln;
    notifyListeners();
  }
}

class DestinationLocation extends Address with ChangeNotifier {
  String name = 'Destination';
  //PickupLocation({this.name = 'Your Location', lat, long}) : super(lat: lat, long: long);

  adddata(String n, double l, double ln) {
    name = n;
    lat = l;
    long = ln;
    notifyListeners();
  }
}

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;
  final apiKey = 'AIzaSyB-GCGoTnknz_lv8-I_zeNr0llIFS123i4';

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&components=country:pk&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future getPlaceDetailFromId(String placeId) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=geometry&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(Uri.parse(request));
    print(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // print("result: ${result['result']['geometry']['location']}");

        return result['result']['geometry']['location'];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
