import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show PlatformException, rootBundle;
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import '../Components/constant.dart';

class HomePageController extends GetxController {
  StreamSubscription? streamSubscription;
  Location? liveLocation = Location();
  LocationData? locationData;
  double? startLatitude;
  double? startLongitude;
  double? endlatitude;
  double? endlongitude;
  double? lastLatitude;
  double? lastLongitude;
  LatLng? startLocation;
  LatLng? endLocation;
  double? speed;
  DateTime? starTime;
  DateTime? endTime;
  DateTime? endTime0;
  bool? startLocationRecorded = false;
  bool? endLocationRecorded = false;
  Set<Marker> markers = Set(); //markers for google map
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = googleMapKey;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  double distance = 0;

  //===================================================

  starTrip() {
    liveLocation!.enableBackgroundMode(enable: true);
    StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
            distanceFilter: 100, forceAndroidLocationManager: true)
        .listen((Position? position) async {
      if (!startLocationRecorded!) {
        startLatitude = position!.latitude;
        startLongitude = position!.longitude;
        startLocationRecorded = true;

        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          googleAPiKey,
          PointLatLng(startLocation!.latitude, startLocation!.longitude),
          PointLatLng(endLocation!.latitude, endLocation!.longitude),
          travelMode: TravelMode.driving,
        );
        if (result.points.isNotEmpty) {
          result.points.forEach((PointLatLng point) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          });
        } else {
          print(result.errorMessage);
        }

        startLocation = LatLng(startLatitude!, startLongitude!);
        markers.add(Marker(
          //add start location marker
          markerId: MarkerId(startLocation.toString()),
          position: startLocation!, //position of marker
          // icon: BitmapDescriptor.defaultMarker, //Icon for Marker
        ));
        update();
      }

      addPolyLine(List<LatLng> polylineCoordinates) {
        PolylineId id = PolylineId("1");
        Polyline polyline = Polyline(
          polylineId: id,
          color: Colors.deepPurpleAccent,
          points: polylineCoordinates,
          width: 8,
        );
        polylines[id] = polyline;
        update();
      }

      endlatitude = position!.latitude;
      endlongitude = position.longitude;

      endLocation = LatLng(endlatitude!, endlongitude!);
      markers.add(Marker(
        //add distination location marker
        markerId: MarkerId(endLocation.toString()),
        position: endLocation!, //position of marker
        // icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      double distanceKm = calculateDistance(
          startLatitude!, startLongitude!, endlatitude!, endlongitude!);
      distance += distanceKm;
      addPolyLine(polylineCoordinates);
      speed = changeSpeedFromMeterToKM(position.speed);
      LatLng newLatLong = LatLng(endlatitude!, endlongitude!);
      googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: newLatLong, zoom: 17)));

      update();
      if (speed == 0) {
        lastLatitude = position.latitude;
        lastLongitude = position.longitude;
        endTime0 = DateTime.now();
        endTime = endTime0;
      }
    });

    update();
  }

  @override
  Marker? marker = Marker(
    markerId: MarkerId("me"),
    position: LatLng(24.6040, 39.6109),
    flat: true,
    draggable: false,
  );
  Circle circle = Circle(
    circleId: CircleId('car'),
    center: LatLng(24.6040, 39.6109),
    strokeColor: Colors.red,
    fillColor: Colors.green.withAlpha(60),
  );

  @override
  void onInit() {
    starTrip();

    print(
        "=============================================== onInit   ========================================");
    super.onInit();
  }

  @override
  void onReady() {
    print(
        "=============================================== onReady   ========================================");
    super.onReady();
  }

  onMapCreated(GoogleMapController gmc) async {
    googleMapController = gmc;
    update();
  }

  Future<Icon> getMarker() async {
    return Icon(Icons.car_crash);
  }

  getCurrentLocation() async {
    try {
      Icon icon = await getMarker();
      var location = await liveLocation!.getLocation();

      if (streamSubscription != null) {
        streamSubscription!.cancel();
      }

      streamSubscription =
          liveLocation!.onLocationChanged.listen((LocationData locationData) {
        LatLng newLatLong =
            LatLng(locationData.latitude, locationData.longitude);
        googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: newLatLong, zoom: 18)));
      });
    } on PlatformException catch (e) {
      print(e.message);
    }
  }
}
