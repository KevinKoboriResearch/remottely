import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
//when delete user, set in users userName to 'user dont exist anymore'

class UsersCollection {
  final auth = FirebaseAuth.instance; //getInstance();//.currentUser()

  
  // bool userExist(uid) {
  //   return firebaseAuth.u//.getUser(uid);
  // }
  // Future<void> userUpdate(
  //     userId, notificationType, dateTime, title, desc) async {
  //   return await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc('${loggedUser.uid}')
  //       .update({
  //     'userName': device.deviceProperty,
  //     'userNickname': device.deviceTitle,
  //     'userAge': device.deviceAdress,
  //     'userBirth': device.deviceLocation,
  //     'user': device.deviceTriggerUrl,
  //     'deviceImageUrl': device.deviceImageUrl,
  //     'deviceUsers': device.deviceUsers,
  //   });

  // Future<void> userInsert(device) async {
  //   await FirebaseFirestore.instance.collection('users').add({
  //     'deviceProperty': device.deviceProperty,
  //     'deviceTitle': device.deviceTitle,
  //     'deviceAdress': device.deviceAdress,
  //     'deviceLocation': device.deviceLocation,
  //     'deviceTriggerUrl': device.deviceTriggerUrl,
  //     'deviceImageUrl': device.deviceImageUrl,
  //   });
  // }

  // Future<void> userUpdate(device) async {
  //   await FirebaseFirestore.instance
  //       .collection("devices")
  //       .doc('${device.id}')
  //       .update({
  //     'deviceProperty': device.deviceProperty,
  //     'deviceTitle': device.deviceTitle,
  //     'deviceAdress': device.deviceAdress,
  //     'deviceLocation': device.deviceLocation,
  //     'deviceTriggerUrl': device.deviceTriggerUrl,
  //     'deviceImageUrl': device.deviceImageUrl,
  //     'deviceUsers': device.deviceUsers,
  //   });
  // }

  // Future<void> userDelete(deviceId) async {
  //   await FirebaseFirestore.instance
  //       .collection('devices')
  //       .doc('$deviceId')
  //       .delete();
  // }
// FirebaseFirestore.instance
//         .collection('devices')
//         .doc('$deviceId').get('userName').toString()

  // Future<DocumentSnapshot> loggedUserGet() {
  //   Future<DocumentSnapshot> loggedUserGet() {
  //   return FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(loggedUser.uid)//.snapshots();
  //       .get();
  // }

  Stream<QuerySnapshot> usersSearchSnapshots() {
    return FirebaseFirestore.instance
        .collection('users')
        .where("userEmail", whereNotIn: [auth.currentUser.email, 'noah@gmail.com'])
        // .where("userEmail", isEqualTo: 'kevin@gmail.com')
        .snapshots();
  }

//  Future<DocumentSnapshot> loggedUserGet() {
  Stream<DocumentSnapshot> userSnapshots(userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots();
  }

  // Future<DocumentSnapshot> userGet(userId) {
  //   return FirebaseFirestore.instance.collection('users').doc(userId).get();
  // }
}
