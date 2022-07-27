import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



showSnakBar(BuildContext context, String text, Duration d) {
  final snackBar = SnackBar(content: Text(text), duration: d);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

String formattedDate(timestamp) {
  var dateFromTimeStamp =
      DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
  return DateFormat('dd-MM-yyyy').format(dateFromTimeStamp);
}

int changeFromMeterToKM(int speed, int factor) {
  return (speed * factor);
}
