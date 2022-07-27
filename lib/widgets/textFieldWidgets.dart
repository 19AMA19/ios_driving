import 'package:flutter/material.dart';

Widget buildNameTextFormField(TextEditingController _controller) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    margin: EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12)),
    child: TextFormField(
      validator: ((value) {
        if (value!.length < 5) {
          return 'Please enter a valid Name';
        } else if (value.length < 5) {
          return 'Name can\'t be less than 5 char';
        } else {
          return null;
        }
      }),
      controller: _controller,
      decoration: InputDecoration(
          hintText: "Fullname",
          icon: Icon(Icons.person),
          border: InputBorder.none),
    ),
  );
}

Widget buildEmailTextFormField(TextEditingController _controller) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    margin: EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12)),
    child: TextFormField(
      validator: ((value) {
        if (value!.length < 5) {
          return 'Please enter a valid Email';
        } else if (value.length < 8) {
          return 'Email can\'t be less than 8 char';
        } else {
          return null;
        }
      }),
      controller: _controller,
      decoration: InputDecoration(
          hintText: "Email", icon: Icon(Icons.email), border: InputBorder.none),
    ),
  );
}

Widget buildPasswordTextFormField(TextEditingController _controller) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    margin: EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12)),
    child: TextFormField(
      obscureText: true,
      validator: ((value) {
        if (value!.length < 4) {
          return 'Please enter strong password';
        } else if (value.length < 6) {
          return 'Password can\'t be less than 6 char';
        } else {
          return null;
        }
      }),
      controller: _controller,
      decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(Icons.lock),
          border: InputBorder.none),
    ),
  );
}

Widget buildPDropDownFormField(List _list) {
  String? selectedValue = '';
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    margin: EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(12)),
    child: DropdownButton(
      items: _list.map((e) {
        return DropdownMenuItem(
          child: Text(e),
          value: selectedValue,
        );
      }).toList(),
      onChanged: (value) {},
    ),
  );
}