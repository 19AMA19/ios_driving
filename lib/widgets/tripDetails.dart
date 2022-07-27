import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class TripDetails extends StatelessWidget {
  final String image;
  final String driverName;
  const TripDetails({
    Key? key,
    required this.image,
    required this.driverName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: EdgeInsets.all(10),
      child: Card(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ListTile(
          leading: CircleAvatar(
            foregroundImage: NetworkImage(image),
          ),
          title: Text(driverName),
          trailing: Text('5KM || Points 88'),
        ),
        Container(
          padding: EdgeInsets.only(left: 10, top: 10),
          child: Row(
            children: [
              Icon(Icons.location_on),
              Text('June 15, 2022,  21:45 | Madinah Alareed'),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Icon(
                Icons.where_to_vote,
                color: Colors.green,
              ),
              Text('June 15, 2022,  22:15 | Madinah Quba'),
            ],
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 15),
              child: ToggleSwitch(
                minWidth: 120.0,
                initialLabelIndex: 1,
                cornerRadius: 10.0,
                activeBgColor: [Colors.green],
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                totalSwitches: 2,
                labels: ['Busniess', 'Psersonal'],
                icons: [Icons.work, Icons.home],
                onToggle: (index) {},
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 15),
          child: ToggleSwitch(
            minWidth: 120.0,
            initialLabelIndex: 1,
            cornerRadius: 10.0,
            activeBgColor: [Colors.deepPurple],
            activeFgColor: Colors.white,
            inactiveBgColor: Colors.grey,
            inactiveFgColor: Colors.white,
            totalSwitches: 2,
            labels: ['Driver', 'Passenger'],
            icons: [Icons.time_to_leave, Icons.airline_seat_recline_extra],
            onToggle: (index) {},
          ),
        ),
      ])),
    );
  }
}
