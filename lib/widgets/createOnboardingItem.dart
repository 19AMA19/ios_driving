import 'package:flutter/material.dart';

class createPage extends StatelessWidget {
  final String title;
  final String image;

  const createPage({
    Key? key, required this.title, required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50, bottom: 80, top: 80),
      child: Column(
        children: [
          SizedBox(
            height: 350,
            child: Image.network(image),
          ),
          SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
