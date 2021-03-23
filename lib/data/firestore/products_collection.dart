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

  Future<void> productInsert(product, imagesSelectedList) async {
    await FirebaseFirestore.instance
        .collection('remottelyCompanies')
        .doc(product.companyTitle) //.doc('tapanapanterahs') //
        .collection('productCategories')
        .doc(product.categoryTitle) //.doc('Tabacos') //
        .collection('products')
        .doc(product.title)
        .set({
      'categoryTitle': product.categoryTitle,
      'coin': product.coin,
      'companyTitle': product.companyTitle,
      'enabled': product.enabled,
      'images': product.images,
      'interested': product.enabled,
      'price': product.price,
      'promotion': product.promotion,
      'rating': product.rating,
      'sizes': product.sizes,
      'subtitle': product.subtitle,
      'title': product.title,
    });
    await FirebaseFirestore.instance.collection('remottelyProducts').add({
      'categoryTitle': product.categoryTitle,
      'coin': product.coin,
      'companyTitle': product.companyTitle,
      'enabled': product.enabled,
      'images': product.images,
      'interested': product.enabled,
      'price': product.price,
      'promotion': product.promotion,
      'rating': product.rating,
      'sizes': product.sizes,
      'subtitle': product.subtitle,
      'title': product.title,
    });
  }

  // Future<void> productUpdate(companyId, product) async {
  //   await FirebaseFirestore.instance
  //       .collection('companies')
  //       .doc(companyId)
  //       .collection('products')
  //       .doc('${product.id}')
  //       .update({
  //     "coin": product.coin,
  //     'companyTitle': product.companyTitle,
  //     'companyRef': product.companyRef,
  //     'description': product.description,
  //     'enabled': product.enabled,
  //     'images': product.images,
  //     'interested': product.enabled,
  //     'price': product.price,
  //     'promotion': product.promotion,
  //     "rating": product.rating,
  //     'sizes': product.sizes,
  //     'subtitle': product.subtitle,
  //     'title': product.title,
  //     'type': product.type,
  //   });
  // }

  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //

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
