import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:remottely/utils/constants.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:remottely/utils/my_flutter_app_icons.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:remottely/utils/my_flutter_app_icons_2.dart';
// import 'package:remottely/widgets/design/app_clipper.dart';
// import 'package:remottely/utils/constants.dart';
// import 'package:remottely/functions/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:remottely/data/firestore/device_triggered_collection.dart';
// import 'package:remottely/data/firestore/devices_collection.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String quantity;
  final String imageUrl;
  bool isFavorite;

  Product({
    this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.quantity,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite(String token, String userId) async {
    _toggleFavorite();

    try {
      final url =
          '${AppURLs.BASE_API_URL}/userFavorites/$userId/$id.json?auth=$token';
      final response = await http.put(
        url,
        body: json.encode(isFavorite),
      );

      if (response.statusCode >= 400) {
        _toggleFavorite();
      }
    } catch (error) {
      _toggleFavorite();
    }
  }

  // final auth = FirebaseAuth.instance;
  // Future<void> deviceInsert(device) async {
  //   List<String> usersList = [auth.currentUser.uid];

  //   await FirebaseFirestore.instance.collection('devices').add({
  //     'deviceProperty': device.deviceProperty,
  //     'deviceTitle': device.deviceTitle,
  //     'deviceAdress': device.deviceAdress,
  //     'deviceLat': device.deviceLat,
  //     'deviceLon': device.deviceLon,
  //     'deviceTriggerUrl': '', //device.deviceTriggerUrl,
  //     'deviceImageUrl': device.deviceImageUrl,
  //     'deviceUsers': usersList,
  //     'deviceManagers': usersList,
  //     'deviceVerified': false,
  //   });
  // }

  // Stream<QuerySnapshot> devicesUserSnapshots() {
  //   return FirebaseFirestore.instance
  //       .collection('devices')
  //       .where(
  //         "deviceUsers",
  //         arrayContains:
  //             // "userEmail": auth.currentUser.email.toLowerCase(),
  //             auth.currentUser.uid,
  //         // "userName": auth.currentUser.displayName.toLowerCase(),
  //       )
  //       // .orderBy("deviceProperty")
  //       .snapshots();
  // }
}
