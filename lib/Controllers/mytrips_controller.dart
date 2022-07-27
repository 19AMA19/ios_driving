import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class TripsPageController extends GetxController {
  double? startLocation;
  double? endLocation;
  double? distance;
  double? score;
  DateTime? starTime;
  DateTime? endTime;

  getAllFeedPosts() async {


    var uid = await FirebaseAuth.instance.currentUser!.uid;
    // var trips = await FirebaseFirestore.instance
    //     .collection('userData')
    //     .doc(uid)
    //     .collection('tripsDetails')
    //     .get()
    //     .then((value) {
    //   print(' ===============  $value');
    // });
  }

  @override
  void onInit() {
    print(' ===============  My trips works');
    getAllFeedPosts();
    super.onInit();
  }
}
