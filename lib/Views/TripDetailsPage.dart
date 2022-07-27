import 'package:flutter/material.dart';

class TripDetails extends StatefulWidget {
  final trips;
  TripDetails({Key? key, this.trips}) : super(key: key);

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
