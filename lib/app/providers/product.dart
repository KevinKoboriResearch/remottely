import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import 'dart:async';

class Product with ChangeNotifier {
  final String id;
  final String coin;
  final String categoryTitle;
  final String companyTitle;
  final String description;
  final bool enabled;
  // final List<ImageModel> images;
  final List images;
  // final List<String> interested;
  final List interested;
  final double price;
  final double promotion;
  final List rating;
  final List sizes;
  final String subtitle;
  final String title;
  final int quantity;
  final DateTime dateModified;
  bool isFavorite;
  bool isOnBag;

  Product({
    this.id,
    this.coin,
    this.categoryTitle,
    this.companyTitle,
    this.description,
    this.enabled,
    this.images,
    this.interested,
    this.price,
    this.promotion,
    this.rating,
    this.sizes,
    this.subtitle,
    this.title,
    this.quantity,
    this.dateModified,
    this.isFavorite,
    this.isOnBag,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'coin': coin,
      'categoryTitle': categoryTitle,
      'companyTitle': companyTitle,
      'description': description,
      'enabled': enabled,
      'images': images,
      'interested': interested,
      'price': price,
      'promotion': promotion,
      'rating': rating,
      'sizes': sizes,
      'subtitle': subtitle,
      'title': title,
      'quantity': quantity,
      'dateModified': dateModified,
      'isFavorite': isFavorite,
      'isOnBag': isOnBag,
    };
  }

  static Product fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;

    return Product(
      id: documentId,
      coin: map['coin'],
      categoryTitle: map['categoryTitle'],
      companyTitle: map['companyTitle'],
      description: map['description'],
      enabled: map['enabled'],
      images: map['images'],
      interested: map['interested'],
      price: map['price'],
      promotion: map['promotion'],
      rating: map['rating'],
      sizes: map['sizes'],
      subtitle: map['subtitle'],
      title: map['title'],
      quantity: map['quantity'],
      dateModified: map['dateModified'],
      isFavorite: map['isFavorite'],
      isOnBag: map['isOnBag'],
    );
  }

  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  // final auth = FirebaseUser.authResult.//.auth.fromApp(app)//.instance.currentUser;

  Future<void> toggleFavorite(
      BuildContext context, String type, String productRef) async {
    if (type == 'favorites') {
      final productsProvider = Provider.of<Products>(context, listen: false);

      // if (productsProvider.favoriteItems.length == 1) {
      //   List<Product> val = [];
      //   productsProvider.setFavoriteItems(val);
      //   notifyListeners();
      // } else {
      List<Product> oldProductsList = productsProvider.items;

      var oldProductIndex = oldProductsList.indexWhere((element) {
        return element.id == id;
      });

      var oldProductItem = oldProductsList.elementAt(oldProductIndex);
      oldProductItem.isFavorite = false;
      oldProductsList
          .replaceRange(oldProductIndex, oldProductIndex + 1, [oldProductItem]);

      productsProvider.setItems(oldProductsList);
      notifyListeners();
    }
    // }
    _toggleFavorite();

    try {
      if (isFavorite == true) {
        await Firestore.instance
            .collection('users')
            .document('FYRjAaP0FHSr6DoFSX5KwVzObcn1')//auth.uid)
            .collection('favorites')
            .document(id)
            .setData(
                {'productReference': productRef, 'companyTitle': companyTitle});
      } else {
        await Firestore.instance
            .collection('users')
            .document('FYRjAaP0FHSr6DoFSX5KwVzObcn1')//auth.uid)
            .collection('favorites')
            .document(id)
            .delete();
      }
    } catch (error) {
      _toggleFavorite();
    }
  }
}
