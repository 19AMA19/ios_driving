import 'dart:ffi';

class Trip {
  Double? lantitude;
  Double? longitude;
  String? address;
  DateTime? start;
  DateTime? end;
  bool? isBusniess;
  bool? isDriver;

  Trip(
      {this.lantitude,
      this.longitude,
      this.address,
      this.start,
      this.end,
      this.isBusniess,
      this.isDriver});

  var trips = [
    Trip(
        lantitude: 23.42423423 as Double,
        longitude: 23.42423423 as Double,
        address: 'Dammam',
        start: DateTime.now(),
        end: DateTime.now(),
        isBusniess: true,
        isDriver: false)
  ];
}
