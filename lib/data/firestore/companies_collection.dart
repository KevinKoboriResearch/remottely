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
// import 'package:remottely/data/firestore/devices_collection.dart';
//  await Firestore.instance.cllection("catogies").document(title.toLowerCase())
//           .setData(dataToUpdaote);
class CompaniesCollection {
  final auth = FirebaseAuth.instance;

  Future<void> companyInsert(company) async {
// //GeoPoint(device.latitude, device.longitude),
// try {


// var exist = await FirebaseFirestore.instance.collection("catgories").doc(company.title.toLowerCase()).get();
// if(exist) {
// return;//ja existe esse nome
// } else {

//   await FirebaseFirestore.instance.collection("catogies").doc(company.title.toLowerCase()).set(company);
// return;//success
// }
//   }       
    await FirebaseFirestore.instance.collection('companies').doc().collection('devices').add({
      'title': company.title,
      'description': company.description,
      'price': company.price,
      'image': {
        'imageUrl': '',
        'imageHeight': 1,
        'imageWidth': 1,
      },
      'interested': [],
      'promotionPrice': company.promotionPrice,
    });
  }

  Future<void> companyUpdate(device) async {
    await FirebaseFirestore.instance
        .collection("devices")
        .doc('${device.id}')
        .update({
      'title': device.title,
      'desc': device.desc,
      'location': device.location,
      'interested': device,
      'verified': device,
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
    var usersList = device['sers'] +
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
  //   // List<String> usersList = ['yBn39ZCTC2WguLaZGIgkRRFPP6R2'];//device['sers'];
  //   var usersList = device[
  //       'sers']; //['O6d6DWBuJdQ42n39nLSZb75eWlo1'];//await friendsList();//['yBn39ZCTC2WguLaZGIgkRRFPP6R2'];//
  //   return FirebaseFirestore.instance
  //       .collection('users')
  //       .doc('${auth.currentUser.uid}')
  //       .collection('userFriendships')
  //       // .where("status", isEqualTo: 'accepted')
  //       .where("userId", whereNotIn: usersList)
  //       .snapshots();
  // }

  Future<void> deviceUpdateDeviceUsers(device, usersList) async {
    // print('${device['sers']}');
    // var usersList = device['sers'] + [userId];
    //  + [userId];
    // usersList.add(userId);
    await FirebaseFirestore.instance
        .collection("devices")
        .doc('${device.id}')
        .update({
      'users': usersList,
    });
  }

  Future<bool> deviceDelete(deviceId) async {
    FirebaseFirestore.instance
        .collection('')
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
        .collection('')
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
        .collection('')
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
  //   return FirebaseFirestore.instance.collection('').snapshots();
  // }

  // devicesGet() async {
  //   return await FirebaseFirestore.instance
  //       .collection('')
  //       .where("deviceUsers", arrayContains: {
  //     "userId": auth.currentUser.uid,
  //     // "userEmail": auth.currentUser.email.toLowerCase(),
  //     // "userName": auth.currentUser.displayName.toLowerCase(),
  //   }).get();
  // }

  deviceSnapshots(deviceId) {
    return FirebaseFirestore.instance
        .collection('')
        .doc('$deviceId')
        .snapshots();
  }

  devicesSnapshots() {
    return FirebaseFirestore.instance.collection('').snapshots();
  }
}
