import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/utils/my_flutter_app_icons_2.dart';
import 'package:remottely/widgets/design/app_clipper.dart';
import 'package:remottely/utils/constants.dart';
import 'package:remottely/functions/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DevicesCollection {
  final auth = FirebaseAuth.instance;

  Future<void> deviceInsert(device) async {
    List<String> usersList = [auth.currentUser.uid];

    await FirebaseFirestore.instance
        .collection('companies')
        .doc('bwBiNTo7yOIUYehamSmD')
        .collection('products')
        .add({
      'deviceProperty': device.deviceProperty,
      'deviceTitle': device.deviceTitle,
      'deviceAdress': device.deviceAdress,
      'deviceLat': device.deviceLat,
      'deviceLon': device.deviceLon,
      'deviceTriggerUrl': '', //device.deviceTriggerUrl,
      'deviceImage': device.deviceImage,
      'deviceUsers': usersList,
      'deviceManagers': usersList,
      'deviceVerified': false,
    });
  }

  Future<void> deviceUpdate(device) async {
    await FirebaseFirestore.instance
        .collection("devices")
        .doc('${device.id}')
        .update({
      'deviceProperty': device.deviceProperty,
      'deviceTitle': device.deviceTitle,
      'deviceAdress': device.deviceAdress,
      'deviceLat': device.deviceLat,
      'deviceLon': device.deviceLon,
      'deviceTriggerUrl': '', //device.deviceTriggerUrl,
      'deviceImage': device.deviceImage,
      'deviceUsers': device.deviceUsers,
      'deviceManagers': device.deviceManagers,
      'deviceVerified': device.deviceVerified,
      // // 'deviceProperty': device.deviceProperty,
      // // 'deviceTitle': device.deviceTitle,
      // // 'deviceAdress': device.deviceAdress,
      // // 'deviceLocation': device.deviceLocation,
      // // 'deviceTriggerUrl': device.deviceTriggerUrl,
      // // 'deviceImageUrl': device.deviceImageUrl,
      // 'deviceProperty': device.deviceProperty,
      // 'deviceTitle': device.deviceTitle,
      // 'deviceAdress': device.deviceAdress,
      // // 'deviceLocation': device.deviceLocation,
      // 'deviceLat': device.deviceLat,
      // 'deviceLon': device.deviceLon,
      // 'deviceTriggerUrl': '', //device.deviceTriggerUrl,
      // 'deviceImageUrl': device.deviceImageUrl,
      // 'deviceUsers': device.deviceUsers,
    });
  }

  FutureOr<List<String>> userFriendshipsNotAcceptedGet() async {
    List<String> friends = [];
    var list = await FirebaseFirestore.instance
        .collection('users')
        .doc('${auth.currentUser.uid}')
        .collection('userFriendships')
        .where("status", isNotEqualTo: 'accepted')
        .get();
    list.docs.forEach((element) {
      friends.add(element.id);
    });
    return friends;
  }

  FutureOr<QuerySnapshot> userFriendshipsAcceptedNotIncludedSnapshots(
      device) async {
    var friends2 = await userFriendshipsNotAcceptedGet();
    var usersList = device['deviceUsers'] +
        friends2; //['O6d6DWBuJdQ42n39nLSZb75eWlo1'];//await friendsList();//['yBn39ZCTC2WguLaZGIgkRRFPP6R2'];//
    return FirebaseFirestore.instance
        .collection('users')
        .doc('${auth.currentUser.uid}')
        .collection('userFriendships')
        // .where("status", isEqualTo: 'accepted')
        .where("userId", whereNotIn: usersList)
        .get();
  }

  // Future<List<String>> friendsList() async {
  //   var friends = [auth.currentUser.uid];
  //   var list = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc('${auth.currentUser.uid}')
  //       .collection('userFriendships')
  //       .get();
  //   list.docs.forEach((element) {
  //     print('element: ${element.id}');
  //     print('element: z1GwphLVQgU8m46H8sDDI4NUxH83');
  //     // friends.add(element.id);
  //     friends.add('zs638ZJW9FP4Rhw1QqYZk5pEE1O2');
  //   });
  //   // print('');
  //   return friends;
  // }

  //  Stream<QuerySnapshot> userFriendshipsAcceptedNotIncludedSnapshots(device) {
  //   // List<String> usersList = ['yBn39ZCTC2WguLaZGIgkRRFPP6R2'];//device['deviceUsers'];
  //   var usersList = device[
  //       'deviceUsers']; //['O6d6DWBuJdQ42n39nLSZb75eWlo1'];//await friendsList();//['yBn39ZCTC2WguLaZGIgkRRFPP6R2'];//
  //   return FirebaseFirestore.instance
  //       .collection('users')
  //       .doc('${auth.currentUser.uid}')
  //       .collection('userFriendships')
  //       // .where("status", isEqualTo: 'accepted')
  //       .where("userId", whereNotIn: usersList)
  //       .snapshots();
  // }

  Future<void> deviceUpdateDeviceUsers(device, usersList) async {
    // print('${device['deviceUsers']}');
    // var usersList = device['deviceUsers'] + [userId];
    //  + [userId];
    // usersList.add(userId);
    await FirebaseFirestore.instance
        .collection("devices")
        .doc('${device.id}')
        .update({
      'deviceUsers': usersList,
    });
  }

  Future<bool> deviceDelete(deviceId) async {
    FirebaseFirestore.instance
        .collection('devices')
        .doc('$deviceId')
        .delete()
        .then((value) {
      return true;
    }).onError((error, stackTrace) {
      return false;
    });
  }

  Stream<QuerySnapshot> devicesUserSnapshots() {
    return FirebaseFirestore.instance
        .collection('devices')
        .where(
          "deviceUsers",
          arrayContains:
              // "userEmail": auth.currentUser.email.toLowerCase(),
              auth.currentUser.uid,
          // "userName": auth.currentUser.displayName.toLowerCase(),
        )
        // .orderBy("deviceProperty")
        .snapshots();
  }

  Stream<QuerySnapshot> devicesManagerSnapshots() {
    return FirebaseFirestore.instance
        .collection('devices')
        .where(
          "deviceManagers",
          arrayContains:
              // "userEmail": auth.currentUser.email.toLowerCase(),
              auth.currentUser.uid.toString(),
          // "userName": auth.currentUser.displayName.toLowerCase(),
        )
        // .orderBy("deviceProperty")
        .snapshots();
  }

  // Stream<QuerySnapshot> devicesSnapshots() {
  //   return FirebaseFirestore.instance.collection('devices').snapshots();
  // }

  // devicesGet() async {
  //   return await FirebaseFirestore.instance
  //       .collection('devices')
  //       .where("deviceUsers", arrayContains: {
  //     "userId": auth.currentUser.uid,
  //     // "userEmail": auth.currentUser.email.toLowerCase(),
  //     // "userName": auth.currentUser.displayName.toLowerCase(),
  //   }).get();
  // }

  deviceSnapshots(deviceId) {
    return FirebaseFirestore.instance
        .collection('devices')
        .doc('$deviceId')
        .snapshots();
  }
}
