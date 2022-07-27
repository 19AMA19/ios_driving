import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String googleMapKey = "AIzaSyDJN-LTWWsfINzXRCLTxGJZpp_t9EWInkQ";
GoogleMapController? googleMapController;

CameraPosition cameraPosition = CameraPosition(
    bearing: 0.0, target: LatLng(24.4515, 39.6154), tilt: 0.0, zoom: 17);

showSnakBar(BuildContext context, String text, Duration d) {
  final snackBar = SnackBar(content: Text(text), duration: d);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

double changeSpeedFromMeterToKM(double speed) {
  return (speed * 3.6);
}

double changeDistancFromMeterToKM(double distance) {
  return (distance / 100.0);
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var a = 0.5 -
      cos((lat2 - lat1) * p) / 2 +
      cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}

// var distancebetween = Geolocator.distanceBetween(
//     startLatitude!, startLongitude!, endlatitude!, endlongitude!);
