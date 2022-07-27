import 'dart:ffi';

import 'package:flutter/material.dart';

class UserModel {
  String? uid;
  String? name;
  DateTime? age;
  String? email;
  String? imageUrl;
  String? division;
  Double? userScore;
  DateTime? createdAt;

  UserModel({
    this.uid,
    this.name,
    this.age,
    this.email,
    this.imageUrl,
    this.division,
    this.userScore,
    this.createdAt,
  });
}
