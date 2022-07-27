import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  String? City;
  getLocation() async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(52.2165157, 6.9437819);
    setState(() {
      // City = placemarks!;
      // print(City);
    });
    print(placemarks);
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffcecece),
      body: Center(
        child: Column(
          children: [
            Text(
              'You don\'t have notifications',
              style: TextStyle(fontSize: 23),
            ),
            City != null
                ? Text(
                    City!,
                    style: TextStyle(fontSize: 23),
                  )
                : Text('data')
          ],
        ),
      ),
    );
  }
}
