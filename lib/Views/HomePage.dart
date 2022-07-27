// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:driving_program/appBrain.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:stop_watch_timer/stop_watch_timer.dart';
// import 'package:timer_count_down/timer_count_down.dart';

// class HomePage extends StatefulWidget {
//   HomePage({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   // ================================================================================
//   double? h;
//   Location location = new Location();
//   LocationData? _locationData;
//   double? _startLatitude;
//   double? _startLongitude;
//   double? _endlatitude;
//   double? _endlongitude;
//   double? _lastLatitude;
//   double? _lastLongitude;
//   DateTime? _starTrip;
//   DateTime? _endTrip;
//   DateTime? _tripDuration;
//   double? _distanceTotal;
//   int? _speed;
//   int? _speedFactor = 3;
//   bool? startLocationRecorded = false;
//   bool? endLocationRecorded = false;
//   String? uid = FirebaseAuth.instance.currentUser!.uid;
//   GoogleMapController? googleMapController;
//   // =================================Timer===============================================
//   final StopWatchTimer _stopWatchTimer = StopWatchTimer();

//   starTimer() {
//     _stopWatchTimer.onExecute.add(StopWatchExecute.start);
//   }

//   resTimer() {
//     _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
//   }

//   timer() {
//     Future.delayed(Duration(seconds: 2), () {
//       _endTrip = DateTime.now();
//       tripDetails();
//       showSnakBar(context, "Trip Recorded", Duration(seconds: 2));
//     });
//   }

//   tripDetails() async {
//     await FirebaseFirestore.instance
//         .collection('userData')
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .collection('tripsDetails')
//         .add({
//       'startTripLocation': '$_startLatitude , $_startLongitude',
//       'endTripLocation': '$_endlatitude , $_endlongitude',
//       'startTripTime': _starTrip,
//       'endTripTime': _endTrip,
//       'TotalDistance': _distanceTotal,
//       // 'TripDuration': '$',
//       'speed': _speed,
//       'score': 100,
//       'uid': uid,
//     });
//   }

//   @override
//   void dispose() async {
//     super.dispose();
//     await _stopWatchTimer.dispose(); // Need to call dispose function.
//   }

//   // ================================================================================
//   Position? MyCurrentLocation;
//   var lat;
//   var lon;
//   CameraPosition? cameraPosition;
//   late StreamSubscription<Position> ps;

//   // ================================================================================

//   Map<MarkerId, Marker> markers = {};
//   Map<PolylineId, Polyline> polylines = {};
//   List<LatLng> polylineCoordinates = [];
//   PolylinePoints polylinePoints = PolylinePoints();
//   String googleAPiKey = "AIzaSyDJN-LTWWsfINzXRCLTxGJZpp_t9EWInkQ";
//   // ================================================================================

//   requestLocationPermission() async {
//     bool? serviceEnabled;
//     LocationPermission? permission;
//     // Request location access
//     serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) {
//         return;
//       }
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }
//     return permission;
//   }

// // ================================================================================

//   getPosition() async {
//     _locationData = await location.getLocation();
//     location.onLocationChanged.listen((LocationData currentLocation) async {
//       try {
//         if (!startLocationRecorded!) {
//           _starTrip = DateTime.now();
//           _startLatitude = _locationData!.latitude!;
//           _startLongitude = _locationData!.longitude!;
//           startLocationRecorded = true;
//         }
//       } catch (e) {
//         print('Error: $e');
//       }

//       setState(() async {
//         _endlatitude = currentLocation.latitude;
//         _endlongitude = currentLocation.longitude;
//         _speed =
//             changeFromMeterToKM(currentLocation.speed!.toInt(), _speedFactor!);
//         print('Speed   =========================  $_speed');
//         print(
//             'tripDuration   =========================  ${_tripDuration.toString()}');

//         switch (_speed) {
//           case 1:
//             {
//               if (_speed! >= 5) {
//                 starTimer();
//                 setState(() {
//                   var distancebetween = Geolocator.distanceBetween(
//                       _startLatitude!,
//                       _startLongitude!,
//                       _endlatitude!,
//                       _endlongitude!);
//                   _distanceTotal = distancebetween;
//                 });
//               }
//             }
//             break;
//           case 0:
//             {
//               if (_speed! == 0) {
//                 resTimer();
//                 setState(() {
//                   endLocationRecorded = true;
//                   _lastLatitude = currentLocation.latitude;
//                   _lastLongitude = currentLocation.longitude;
//                   timer();
//                 });
//               }
//             }
//             break;
//         }

//         // if (_speed! > 5) {
//         //   starTimer();
//         //   var distancebetween = Geolocator.distanceBetween(
//         //       _startLatitude!, _startLongitude!, _endlatitude!, _endlongitude!);
//         //   _distanceTotal = distancebetween;
//         // } else if (_speed! == 0) {
//         //   endTimer();
//         //   _endTrip = DateTime.now();
//         //   endLocationRecorded = true;
//         //   _lastLatitude = currentLocation.latitude;
//         //   _lastLongitude = currentLocation.longitude;
//         // tripDetails();
//         // Countdown(
//         //     seconds: 10,
//         //     build: (_, double time) => Text(
//         //           time.toString(),
//         //           style: TextStyle(
//         //             fontSize: 100,
//         //           ),
//         //         ),
//         //     interval: Duration(milliseconds: 100),
//         //     onFinished: () async {

//         //     });
//         // }
//       });
//     });
//   }

//   // ================================================================================
//   Future<void> getMyCurrentLocation() async {
//     MyCurrentLocation =
//         await Geolocator.getCurrentPosition().then((value) => value);
//     lat = MyCurrentLocation!.latitude;
//     lon = MyCurrentLocation!.longitude;

//     cameraPosition = CameraPosition(target: LatLng(lat, lon), zoom: 20);
//     myMarker.add(
//       Marker(markerId: MarkerId("1"), position: LatLng(lat, lon)),
//     );
//     setState(() {});
//   }
//   // ================================================================================

//   Set<Marker> myMarker = {};
//   // ================================================================================
//   addMarkers(newLat, newLon) {
//     setState(() {
//       myMarker.clear();
//       myMarker.add(Marker(markerId: MarkerId("1"), position: LatLng(lat, lon)));
//       googleMapController!
//           .animateCamera(CameraUpdate.newLatLng(LatLng(lat, lon)));
//     });
//   }
//   // ================================================================================

//   stremposition() async {
//     ps = await Geolocator.getPositionStream().listen((Position? position) {
//       addMarkers(position!.latitude, position.longitude);
//     });
//   }

// // ==============================
//   @override
//   void initState() {
//     getPolyline();
//     requestLocationPermission();
//     getMyCurrentLocation();
//     getPosition();
//     timer();
//     stremposition();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             children: [
//               Container(
//                   height: 400,
//                   width: double.infinity,
//                   color: Colors.amber,
//                   child: cameraPosition != null
//                       ? GoogleMap(
//                           myLocationEnabled: true,
//                           tiltGesturesEnabled: true,
//                           compassEnabled: true,
//                           scrollGesturesEnabled: true,
//                           zoomGesturesEnabled: true,
//                           polylines: Set<Polyline>.of(polylines.values),
//                           markers: myMarker,
//                           mapType: MapType.normal,
//                           initialCameraPosition: cameraPosition!,
//                         )
//                       : Center(child: Text('Loading'))),
//               SizedBox(height: 20),
//               Text(
//                 'Current Lati: ${_endlatitude.toString()} || Current Long: ${_endlongitude.toString()}',
//                 style: TextStyle(fontSize: 13),
//               ),
//               Text(
//                 'Start Lati: ${_startLatitude.toString()} || Start Long:  ${_startLongitude.toString()}',
//                 style: TextStyle(fontSize: 13),
//               ),
//               Text(
//                 'Last Lati: ${_lastLatitude.toString()} || Last Long:  ${_lastLongitude.toString()}',
//                 style: TextStyle(fontSize: 13),
//               ),
//               _speed != null
//                   ? Text('Speed: ${_speed!.round()}')
//                   : Text('No Data'),
//               _distanceTotal != null
//                   ? Text('Distance: ${_distanceTotal} KM')
//                   : Text('Distance: No Data'),
//               SizedBox(height: 20),
//               Text('Time: ', style: TextStyle(fontSize: 20)),
//               CountTime(stopWatchTimer: _stopWatchTimer),
//               // Countdown(
//               //     seconds: 30,
//               //     build: (_, double time) => Text(
//               //           time.toString(),
//               //           style: TextStyle(
//               //             fontSize: 100,
//               //           ),
//               //         ),
//               //     interval: Duration(seconds: 30),
//               //     onFinished: () {
//               //       tripDetails();
//               //     }),
//             ],
//           ),
//         ),
//       ),
//       backgroundColor: Color(0xffcecece),
//     );
//   }

//   addPolyLine() {
//     PolylineId id = PolylineId("poly");
//     Polyline polyline = Polyline(
//         polylineId: id, color: Colors.green, points: polylineCoordinates);
//     polylines[id] = polyline;
//     setState(() {});
//   }

//   getPolyline() async {
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//         googleAPiKey,
//         PointLatLng(_startLatitude!, _startLongitude!), // Start
//         PointLatLng(_endlatitude!, _endlongitude!), //End
//         travelMode: TravelMode.driving,
//         wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]);
//     setState(() {
//       // if (result.points.isNotEmpty) {
//       //   result.points.forEach((PointLatLng point) {
//       polylineCoordinates
//           .add(LatLng(_startLatitude!, _startLongitude!)); // Start
//       polylineCoordinates.add(LatLng(_endlatitude!, _endlongitude!)); //End
//       // });
//       // }
//     });
//     addPolyLine();
//   }
// }

// class CountTime extends StatelessWidget {
//   const CountTime({
//     Key? key,
//     required StopWatchTimer stopWatchTimer,
//   })  : _stopWatchTimer = stopWatchTimer,
//         super(key: key);

//   final StopWatchTimer _stopWatchTimer;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<int>(
//       stream: _stopWatchTimer.rawTime,
//       initialData: 0,
//       builder: (context, snap) {
//         final value = snap.data;
//         final displayTime = StopWatchTimer.getDisplayTime(
//           value!,
//           hours: true,
//           minute: true,
//           second: true,
//           milliSecond: false,
//         );
//         return Container(
//           child: Text(
//             displayTime,
//             style: TextStyle(
//                 fontSize: 40,
//                 fontFamily: 'Helvetica',
//                 fontWeight: FontWeight.bold),
//           ),
//         );
//       },
//     );
//   }
// }