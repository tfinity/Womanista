import 'dart:convert';

import 'package:http/http.dart';

Future<String> calculateDistance(
    double desLat, double desLng, double originLat, double originLng) async {
  final client = Client();
  final request =
      'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=$desLat,$desLng&origins=$originLat,$originLng&units=imperial&key=AIzaSyB-GCGoTnknz_lv8-I_zeNr0llIFS123i4';
  print(request);
  final response = await client.get(Uri.parse(request));
  final result = json.decode(response.body);
  return result['rows'][0]['elements'][0]['distance']['text'].toString();
}
