import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:remottely/exceptions/http_exception.dart';
import 'package:remottely/utils/constants.dart';
import './product.dart';

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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:remottely/providers/auth.dart';
import 'package:remottely/utils/my_flutter_app_icons.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import '../utils/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Products with ChangeNotifier {
  final String _baseUrl = '${AppURLs.BASE_API_URL}/products';
  List<Product> _items = [];
  String _token;
  String _userId;
final auth = FirebaseAuth.instance.currentUser;
  Products([this._token, this._userId, this._items = const []]);

  List<Product> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  Future<void> loadProducts() async {
    final response = await http.get("$_baseUrl.json?auth=$_token");
    Map<String, dynamic> data = json.decode(response.body);

    final favResponse = await http.get(
        "${AppURLs.BASE_API_URL}/userFavorites/$_userId.json?auth=$_token");
    final favMap = json.decode(favResponse.body);

    _items.clear();
    if (data != null) {
      data.forEach((productId, productData) {
        final isFavorite = favMap == null ? false : favMap[productId] ?? false;
        _items.add(Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          price: productData['price'],
          quantity: productData['quantity'],
          imageUrl: productData['imageUrl'],
          isFavorite: isFavorite,
        ));
      });
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> addProduct(Product newProduct) async {
    final response = await http.post(
      "$_baseUrl.json?auth=$_token",
      body: json.encode({
        'title': newProduct.title,
        'description': newProduct.description,
        'price': newProduct.price,
        'quantity': newProduct.quantity,
        'imageUrl': newProduct.imageUrl,
      }),
    );

    _items.add(Product(
      id: json.decode(response.body)['name'],
      title: newProduct.title,
      description: newProduct.description,
      price: newProduct.price,
      quantity: newProduct.quantity,
      imageUrl: newProduct.imageUrl,
    ));
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    if (product == null || product.id == null) {
      return;
    }

    final index = _items.indexWhere((prod) => prod.id == product.id);
    if (index >= 0) {
      await http.patch(
        "$_baseUrl/${product.id}.json?auth=$_token",
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'quantity': product.quantity,
          'imageUrl': product.imageUrl,
        }),
      );
      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final index = _items.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();

      final response =
          await http.delete("$_baseUrl/${product.id}.json?auth=$_token");

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpException('Ocorreu um erro na exclusão do produto.');
      }
    }
  }

//
//
//
//FIRESTORE

  // final auth = FirebaseAuth.instance;
  // final Auth auth = Provider.of(context, listen: false);

  Future<void> productInsert(auth, Product newProduct) async {
    // List<String> usersList = [auth.currentUser.uid];

    await FirebaseFirestore.instance
        .collection('users')
        // .doc('${auth.currentUser.uid}')
        .doc('${auth.userId}')
        .collection('products')
        .add({
      'title': newProduct.title,
      'description': newProduct.description,
      'price': newProduct.price,
      'quantity': newProduct.quantity,
      'imageUrl': newProduct.imageUrl,
    });
  }

  Stream<QuerySnapshot> productsUserSnapshots(auth) {
    return FirebaseFirestore.instance
        .collection('users')
        // .doc('${auth.currentUser.uid}')
        .doc('${auth.userId}')
        .collection('products')
        // .where(
        //   "deviceUsers",
        //   arrayContains:
        //       // "userEmail": auth.currentUser.email.toLowerCase(),
        //       auth.currentUser.uid,
        //   // "userName": auth.currentUser.displayName.toLowerCase(),
        // )
        // .orderBy("deviceProperty")
        .snapshots();
  }
}

// bool _showFavoriteOnly = false;

// void showFavoriteOnly() {
//   _showFavoriteOnly = true;
//   notifyListeners();

// }
// void showAll() {
//   _showFavoriteOnly = false;
//   notifyListeners();
// }
