import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DriversPage extends StatefulWidget {
  DriversPage({Key? key}) : super(key: key);

  @override
  State<DriversPage> createState() => _DriversPageState();
}

class _DriversPageState extends State<DriversPage> {
  int userIndex = 1;
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('userData')
      .orderBy('userScore', descending: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffcecece),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      foregroundImage: NetworkImage(data['imageUrl']),
                    ),
                    title: Text(data['fullname']),
                    subtitle: Text(
                        '${data['division']} -  Scores: ${data['userScore']}'),
                    trailing: Column(
                      children: [
                        Text('Rank'),
                        Text('# ${userIndex++}'),
                      ],
                    ),
                  )
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
