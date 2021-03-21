import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:remottely/data/firestore/notifications_collection.dart';

class DeviceTriggered {
  final auth = FirebaseAuth.instance;

  Future<void> deviceTriggeredInsert(device, triggeredType) async {
    final dateTime = DateTime.now();
    var userData = {
      "userId": auth.currentUser.uid,
      "userEmail": auth.currentUser.email
    };
    await NotificationsCollection().notificationDeviceTriggeredInsert(
        device['deviceManagers'],
        triggeredType,
        dateTime,
        device);
    await FirebaseFirestore.instance
        .collection('devices')
        .doc('${device.id}')
        .collection('deviceTriggered')
        .add({
      'deviceTriggeredType': triggeredType,
      'deviceTriggeredDateTime': dateTime.toIso8601String(),
      'deviceTriggeredUser': userData,
      'deviceTriggeredUserLat': device['deviceLat'],
      'deviceTriggeredUserLon': device['deviceLon'],
    });
  }

  Stream<QuerySnapshot> userDeviceTriggeredSnapshots(deviceId) {
    return FirebaseFirestore.instance
        .collection('devices')
        .doc('$deviceId')
        .collection('deviceTriggered')
        .where("deviceTriggeredUser", isEqualTo: {
          "userId": auth.currentUser.uid,
          "userEmail": auth.currentUser.email,
        })
        .orderBy("deviceTriggeredDateTime")
        .snapshots();
  }

  // Stream<QuerySnapshot> userDeviceEventsTriggeredSnapshots(device) {
  //   return FirebaseFirestore.instance
  //       .collection('devices')
  //       .doc()
  //       .collection('deviceTriggered')
  //       .where("deviceTriggeredType", isEqualTo: 'event')
  //       .where("deviceTriggeredUser", isEqualTo: {
  //         "userId": auth.currentUser.uid,
  //         "userEmail": auth.currentUser.email,
  //       })
  //       .orderBy("deviceTriggeredDateTime")
  //       .snapshots();
  // }

  // Stream<QuerySnapshot> deviceEventsTriggeredSnapshots(device) {
  //   return FirebaseFirestore.instance
  //       .collection('devices')
  //       .doc()
  //       .collection('deviceTriggered')
  //       .where("deviceTriggeredType", isEqualTo: 'event')
  //       .orderBy("deviceTriggeredDateTime")
  //       .snapshots();
  // }

  Stream<QuerySnapshot> deviceTriggeredSnapshots(deviceId) {
    return FirebaseFirestore.instance
        .collection('devices')
        .doc('$deviceId')
        .collection('deviceTriggered')
        // .orderBy("deviceTriggeredDateTime")
        .snapshots();
  }
}
