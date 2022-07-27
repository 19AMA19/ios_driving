import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../widgets/tripDetails.dart';

class MyTripsPage extends StatefulWidget {
  MyTripsPage({Key? key}) : super(key: key);

  @override
  State<MyTripsPage> createState() => _MyTripsPageState();
}

class _MyTripsPageState extends State<MyTripsPage> {
  // CollectionReference UserTrips =
  //     FirebaseFirestore.instance.collection('userData').doc();
  final Stream<QuerySnapshot> UserTrips = FirebaseFirestore.instance.collection('userData').where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffcecece),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: UserTrips,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int i) {
                return Column(
                  children: [
                    // TripDetails(image: '${data['speed']}', driverName: '${data['speed']}',),
                    Text('${snapshot.data!.docs[i]['tripsDetails']}'),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// StreamBuilder<QuerySnapshot>(
//           stream: _usersStream,
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.hasError) {
//               return Text('Something went wrong');
//             }
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Text("Loading");
//             }
//             return ListView(
//               children: snapshot.data!.docs.map((DocumentSnapshot document) {
//                 Map<String, dynamic> data =
//                     document.data()! as Map<String, dynamic>;
//                 return Column(
//                   children: [TripDetails(image: '${data['imageUrl']}', driverName: '${data['fullname']}',)],
//                 );
//               }).toList(),
//             );
//           },
//         ),
