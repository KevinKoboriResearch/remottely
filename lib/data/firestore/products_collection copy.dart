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
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:remottely/models/image_model.dart';
import 'package:remottely/models/product_model.dart';
import 'package:remottely/data/firestore/products_collection.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import 'package:remottely/utils/constants.dart';
import 'package:remottely/utils/via_cep_service.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:remottely/exceptions/http_exception.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:ui';
import 'dart:io';
import 'package:remottely/utils/my_flutter_app_icons_2.dart';

import 'package:remottely/functions/flushbar.dart';
import 'package:flutter/services.dart';
import 'package:remottely/functions/streams.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:remottely/validators/product_validators.dart';

import 'package:remottely/styles/product_styles.dart';
// import 'package:remottely/data/firestore/products_collection.dart';

class ProductsCollection {
  final auth = FirebaseAuth.instance;

  List<Map<String, Object>> productInsert(
      companyId, product, imagesSelectedList) {
    List<Map<String, Object>> allImagesSelectedUrl = [];
    // String productId = '';
    FirebaseFirestore.instance
        .collection('companies')
        .doc(companyId)
        .collection('products')
        .add({
      "coin": product.coin,
      'companyTitle': product.companyTitle,
      'description': product.description,
      'images': [],
      'interested': [],
      'price': product.price,
      'promotion': product.promotion,
      "rating": 0.0,
      'subtitle': product.subtitle,
      'title': product.title,
    });

    // .then((product) {
    //   // productId = product.id.toString();
    //   print('3\n33\n333\n3333\n33333\n333333\n3333333\n33333333\n');
    //   // List<Map<String, Object>> allImagesSelectedUrl = [];

    //   if (imagesSelectedList != []) {
    //     // for (var i; i <= imagesSelectedList.length; i++) {
    //     getlist() {
    //       // List<Map<String, Object>> allImagesSelectedUrl = [];
    //       for (var imageFile in imagesSelectedList) {
    //         var archive = FirebaseStorage.instance
    //             .ref()
    //             .child('company')
    //             .child('product_images')
    //             // .child(product.id.toString() + '$i' + '.jpg');
    //             .child(product.id.toString() + '$imageFile' + '.jpg');

    //         // UploadTask task = archive.putFile(imagesSelectedList[i]);
    //         UploadTask task = archive.putFile(imageFile);

    //         task.whenComplete(() async {
    //           var url = await (await task).ref.getDownloadURL();
    //           // var _decodedProfileImage = await decodeImageFromList(
    //           await decodeImageFromList(
    //               // imagesSelectedList[i].readAsBytesSync());
    //               imageFile.readAsBytesSync()).then((value) {
    //             allImagesSelectedUrl.add({
    //               'height': value.height,
    //               'url': url,
    //               'width': value.width,
    //             });
    //             print('4\n444\n444\n4444\n44444\n444444\n4444444\n44444444\n' +
    //                 allImagesSelectedUrl.toString());
    //           });
    //           // return;
    //         });
    //       }
    //       // return allImagesSelectedUrl;
    //     }

    //     // var oi = getlist();

    //     // productImagesUpdate(companyId, product, oi);
    //     // .then((value) {
    //     // await FirebaseFirestore.instance
    //     //     .collection('companies')
    //     //     .doc(companyId)
    //     //     .collection('products')
    //     //     .doc(product.id)
    //     //     .update({
    //     //   "images":
    //     //       // [
    //     //       //   {'oi': 'pqp'}
    //     //       // ], //
    //     //       allImagesSelectedUrl,
    //     // });
    //     // print('5\n555\n555\n5555\n55555\n555555\n5555555\n55555555\n' +
    //     //     allImagesSelectedUrl.toString());
    //     // });
    //     // if (allImagesSelectedUrl.length == imagesSelectedList.length) {
    //     // FirebaseFirestore.instance
    //     //     .collection('companies')
    //     //     .doc(companyId)
    //     //     .collection('products')
    //     //     .doc(product.id)
    //     //     .update({
    //     //   "images":
    //     //       // [
    //     //       //   {'oi': 'pqp'}
    //     //       // ], //
    //     //       allImagesSelectedUrl,
    //     // });
    //     // print('5\n555\n555\n5555\n55555\n555555\n5555555\n55555555\n' +
    //     //     allImagesSelectedUrl.toString());
    //     // return;
    //     // }
    //   }
    // });
    // // .whenComplete(() {
    // //   productImagesUpdate(companyId, 'SbRClrDnmZ40le7LUMvJ', allImagesSelectedUrl);
    // // });
    // return allImagesSelectedUrl;//productId;
  }

  Future productImagesUpdate(companyId, productId, allImagesSelectedUrl) async {
    for (int i = 0; i < allImagesSelectedUrl.length; i++) {
      if (allImagesSelectedUrl[i] is String) continue;

      var uploadTask = FirebaseStorage.instance
          .ref()
          .child(companyId)
          .child(productId)
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(allImagesSelectedUrl[i]);
// var s = 
      await uploadTask.whenComplete(() async {
        var downloadUrl = await (await uploadTask).ref.getDownloadURL();
        // String downloadUrl = await s.ref.getDownloadURL();
        allImagesSelectedUrl[i] = downloadUrl;
      });
    }
  }

  // Future<void> productImagesUpdate(
  //     companyId, productId, allImagesSelectedUrl) async {
  //   await FirebaseFirestore.instance
  //       .collection('companies')
  //       .doc(companyId)
  //       .collection('products')
  //       .doc(productId)
  //       .update({
  //     "images":
  //         // [
  //         //   {'oi': 'pqp'}
  //         // ], //
  //         allImagesSelectedUrl,
  //   });
  //   print('5\n555\n555\n5555\n55555\n555555\n5555555\n55555555\n' +
  //       allImagesSelectedUrl.toString());
  // }

  // Future<void> productInsert(companyId, product) async {
  //   await FirebaseFirestore.instance
  //       .collection('companies')
  //       .doc(companyId)
  //       .collection('products')
  //       .add({
  //     "coin": product.coin,
  //     'companyTitle': product.companyTitle,
  //     'description': product.description,
  //     'images': [
  //       {
  //         'imageUrl': '',
  //         'imageHeight': 1,
  //         'imageWidth': 1,
  //       }
  //     ],
  //     'interested': [],
  //     'price': product.price,
  //     'promotionPrice': product.promotionPrice,
  //     "rating": null,
  //     'subtitle': product.subtitle,
  //     'title': product.title,
  //   });
  // }

  Future<void> productUpdate(product) async {
    await FirebaseFirestore.instance
        .collection("products")
        .doc('${product.id}')
        .update({
      'title': product.title,
      'desc': product.desc,
      'location': product.location,
      'interested': product,
      'verified': product,
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
      product) async {
    var friends2 = await userFriendshipsNotAcceptedGet();
    var usersList = product['sers'] +
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

  //  Stream<QuerySnapshot> userFriendshipsAcceptedNotIncludedSnapshots(product) {
  //   // List<String> usersList = ['yBn39ZCTC2WguLaZGIgkRRFPP6R2'];//product['sers'];
  //   var usersList = product[
  //       'sers']; //['O6d6DWBuJdQ42n39nLSZb75eWlo1'];//await friendsList();//['yBn39ZCTC2WguLaZGIgkRRFPP6R2'];//
  //   return FirebaseFirestore.instance
  //       .collection('users')
  //       .doc('${auth.currentUser.uid}')
  //       .collection('userFriendships')
  //       // .where("status", isEqualTo: 'accepted')
  //       .where("userId", whereNotIn: usersList)
  //       .snapshots();
  // }

  Future<void> productUpdateproductUsers(product, usersList) async {
    // print('${product['sers']}');
    // var usersList = product['sers'] + [userId];
    //  + [userId];
    // usersList.add(userId);
    await FirebaseFirestore.instance
        .collection("products")
        .doc('${product.id}')
        .update({
      'users': usersList,
    });
  }

  Future<bool> productDelete(productId) async {
    FirebaseFirestore.instance
        .collection('')
        .doc('$productId')
        .delete()
        .then((value) {
      return true;
    }).onError((error, stackTrace) {
      return false;
    });
  }

  Stream<QuerySnapshot> productsUserSnapshots() {
    return FirebaseFirestore.instance
        .collection('')
        .where(
          "productUsers",
          arrayContains:
              // "userEmail": auth.currentUser.email.toLowerCase(),
              auth.currentUser.uid,
          // "userName": auth.currentUser.displayName.toLowerCase(),
        )
        // .orderBy("productProperty")
        .snapshots();
  }

  Stream<QuerySnapshot> productsManagerSnapshots() {
    return FirebaseFirestore.instance
        .collection('')
        .where(
          "productManagers",
          arrayContains:
              // "userEmail": auth.currentUser.email.toLowerCase(),
              auth.currentUser.uid.toString(),
          // "userName": auth.currentUser.displayName.toLowerCase(),
        )
        // .orderBy("productProperty")
        .snapshots();
  }

  // Stream<QuerySnapshot> productsSnapshots() {
  //   return FirebaseFirestore.instance.collection('').snapshots();
  // }

  // productsGet() async {
  //   return await FirebaseFirestore.instance
  //       .collection('')
  //       .where("productUsers", arrayContains: {
  //     "userId": auth.currentUser.uid,
  //     // "userEmail": auth.currentUser.email.toLowerCase(),
  //     // "userName": auth.currentUser.displayName.toLowerCase(),
  //   }).get();
  // }

  productSnapshots(productId) {
    return FirebaseFirestore.instance
        .collection('')
        .doc('$productId')
        .snapshots();
  }

  productsSnapshots() {
    return FirebaseFirestore.instance.collection('').snapshots();
  }
}
