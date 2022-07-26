import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../Components/constant.dart';
import '../Controllers/home_page_controller.dart';

class HomePagea extends StatelessWidget {
  Location location = new Location();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: GetBuilder<HomePageController>(
          init: HomePageController(),
          builder: (controller) => Column(
            children: [
              Container(
                height: 300,
                child: GoogleMap(
                  polylines: Set<Polyline>.of(controller.polylines.values),
                  markers: controller.markers,
                  initialCameraPosition: cameraPosition,
                  mapType: MapType.hybrid,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  onMapCreated: (GoogleMapController gmc) {
                    controller.onMapCreated(gmc);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.speed != null
                        ? Text('Speed:${controller.speed!.toStringAsFixed(0)}',
                            style: TextStyle(fontSize: 50, color: Colors.red))
                        : Text('Speed:',
                            style: TextStyle(fontSize: 50, color: Colors.red)),
                    controller.startLatitude != null
                        ? Text(
                            'Start Lati: ${controller.startLatitude!.toStringAsFixed(6)}',
                            style: TextStyle(fontSize: 22),
                          )
                        : Text('Start Longitude'),
                    controller.startLongitude != null
                        ? Text(
                            'Start Long: ${controller.startLongitude!.toStringAsFixed(6)}',
                            style: TextStyle(fontSize: 22),
                          )
                        : Text('Time'),
                    Text('Time: ${controller.starTime}',
                        style: TextStyle(fontSize: 15)),
                    Text(
                      '=====================',
                      style: TextStyle(fontSize: 20),
                    ),
                    controller.endlatitude != null
                        ? Text(
                            'endlatitude: ${controller.endlatitude!.toStringAsFixed(6)}',
                            style: TextStyle(fontSize: 20),
                          )
                        : Text('end Long', style: TextStyle(fontSize: 22)),
                    controller.endlongitude != null
                        ? Text(
                            'end Long: ${controller.endlongitude!.toStringAsFixed(6)}',
                            style: TextStyle(fontSize: 20),
                          )
                        : Text('Distance', style: TextStyle(fontSize: 22)),
                    controller.distance != null
                        ? Text(
                            'Distance : ${controller.distance.toStringAsFixed(3)}',
                            style: TextStyle(fontSize: 20),
                          )
                        : Text('Time', style: TextStyle(fontSize: 22)),
                    Text(
                      'Time: ${controller.endTime}',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
